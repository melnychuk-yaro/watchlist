import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchlist/business_logic/helpers/failure.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/models/moviesPage.dart';
import 'package:watchlist/data/repositories/auth_repository.dart';

class MoviesRepository {
  static const String urlAuthority = 'api.themoviedb.org';
  static const String pathPrefix = '/3';
  static const String includeAdult = 'false';
  static const String language = 'en-US';
  final String? apiKey = env['TMDB_API_KEY'];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  Future<MoviesPage> getTopRatedMovies({page = 1}) async {
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

  Future<MoviesPage> getNewMovies({page = 1}) async {
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

  Future<void> saveFavMovie(Movie movie) async {
    try {
      Map<String, dynamic> movieMap = movie.toMap();
      movieMap['date_added_to_favorite'] =
          DateTime.now().millisecondsSinceEpoch;

      return await firestore
          .collection('users')
          .doc(authenticationRepository.currentUser.id)
          .collection('fav_movies')
          .doc(movie.id.toString())
          .set(movieMap);
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t save movie.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<void> removeFavMovie(int? id) async {
    try {
      return await firestore
          .collection('users')
          .doc(authenticationRepository.currentUser.id)
          .collection('fav_movies')
          .doc(id.toString())
          .delete();
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t remove movie.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<List<Movie>> getFavMovies() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(authenticationRepository.currentUser.id)
          .collection('fav_movies')
          .orderBy('date_added_to_favorite', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => Movie.fromMap(doc.data()!, isFavorite: true))
          .toList();
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t remove movie.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<MoviesPage> _getMoviesPage(http.Response response) async {
    try {
      Map<String, dynamic> body = json.decode(response.body);
      List results = body['results'];
      List<int?> favIds = await _getFavoritesIds();
      return MoviesPage(
          isLastPage: body['page'] >= body['total_pages'],
          itemList: results.map((movieMap) {
            return Movie.fromMap(
              movieMap,
              isFavorite: favIds.contains(movieMap['id']),
            );
          }).toList());
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<List<int?>> _getFavoritesIds() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(authenticationRepository.currentUser.id)
          .collection('fav_movies')
          .get();
      return snapshot.docs.map((doc) => doc['id'] as int?).toList();
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t find movies.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Uri _buildUri({required String path, required int page, String? query}) {
    return Uri.https(
      urlAuthority,
      pathPrefix + path,
      {
        'api_key': apiKey,
        'language': language,
        'page': page.toString(),
        'include_adult': includeAdult,
        if (query != null) 'query': query,
      },
    );
  }
}
