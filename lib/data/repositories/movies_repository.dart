import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../business_logic/helpers/failures/failure.dart';
import '../models/movie.dart';
import '../models/movie_detailed.dart';
import '../models/movies_page.dart';

class MoviesRepository {
  static const String urlAuthority = 'api.themoviedb.org';
  static const String pathPrefix = '/3';
  static const String includeAdult = 'false';
  static const String language = 'en-US';
  final String? _apiKey = env['TMDB_API_KEY'];

  Future<MoviesPage> getTopRatedMovies({int? page = 1}) async {
    final uri = _buildUri(path: '/movie/top_rated', page: page);

    try {
      final response = await http.get(uri);

      return response.statusCode == 200
          ? await _getMoviesPage(response)
          : throw Failure(
              'Error fetching movies. Code: ${response.statusCode}');
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t find movies.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<MoviesPage> getNewMovies({int? page = 1}) async {
    final uri = _buildUri(path: '/movie/now_playing', page: page);
    try {
      final response = await http.get(uri);
      return response.statusCode == 200
          ? await _getMoviesPage(response)
          : throw Failure(
              'Error fetching movies. Code: ${response.statusCode}');
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t find movies.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<MoviesPage> searchMovies({String? query, int page = 1}) async {
    final uri = _buildUri(path: '/search/movie', page: page, query: query);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return await _getMoviesPage(response);
      } else if (response.statusCode == 422) {
        return MoviesPage(itemList: <Movie>[], isLastPage: true);
      } else {
        throw Failure(
            'Error fetching movies. Uri: /search/movie. Query: $query');
      }
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t find movies.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<MovieDetailed> getSingleMovie({required int id}) async {
    final uri = _buildUri(
        path: '/movie/$id', queryParameters: {'append_to_response': 'videos'});
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        return MovieDetailed.fromMap(body);
      } else {
        throw Failure('Error fetching movie. Id: $id');
      }
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t find movies.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<MoviesPage> _getMoviesPage(http.Response response) async {
    try {
      Map<String, dynamic> body = json.decode(response.body);
      List results = body['results'];
      return MoviesPage(
          isLastPage: body['page'] >= body['total_pages'],
          itemList: results.map((movieMap) {
            return Movie.fromMap(movieMap);
          }).toList());
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Uri _buildUri({
    required String path,
    int? page,
    String? query,
    Map<String, dynamic>? queryParameters,
  }) {
    return Uri.https(
      urlAuthority,
      pathPrefix + path,
      {
        'api_key': _apiKey,
        'language': language,
        'include_adult': includeAdult,
        if (page != null) 'page': page.toString(),
        if (query != null) 'query': query,
        if (queryParameters != null) ...queryParameters,
      },
    );
  }
}
