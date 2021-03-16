import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchlist/business_logic/helpers/failure.dart';
import 'package:watchlist/data/models/favoritesMoviesPage.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/models/moviesPage.dart';

class MoviesRepository {
  static const String urlAuthority = 'api.themoviedb.org';
  static const String pathPrefix = '/3';
  static const String includeAdult = 'false';
  static const String language = 'en-US';
  final String? _apiKey = env['TMDB_API_KEY'];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> saveFavMovie(
      {required Movie movie, required String userId}) async {
    try {
      Map<String, dynamic> movieMap = movie.toMap();
      movieMap['date_added_to_favorite'] =
          DateTime.now().millisecondsSinceEpoch;

      return await _firestore
          .collection('users')
          .doc(userId)
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

  Future<void> removeFavMovie({required int id, required String userId}) async {
    try {
      return await _firestore
          .collection('users')
          .doc(userId)
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

  Future<FavoritesMoviesPage> getFavMovies({
    required String userId,
    DocumentSnapshot? lastDocument,
  }) async {
    QuerySnapshot querySnapshot;
    const limit = 10;
    try {
      querySnapshot = lastDocument == null
          ? await _firestore
              .collection('users')
              .doc(userId)
              .collection('fav_movies')
              .orderBy('date_added_to_favorite', descending: true)
              .limit(limit)
              .get()
          : await _firestore
              .collection('users')
              .doc(userId)
              .collection('fav_movies')
              .orderBy('date_added_to_favorite', descending: true)
              .startAfterDocument(lastDocument)
              .limit(limit)
              .get();

      bool isLastPage = querySnapshot.docs.length < limit ? true : false;
      if (querySnapshot.docs.length > 0) {
        lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      List<Movie> movies = querySnapshot.docs.map((doc) {
        if (doc.data() == null) throw Failure('Bad response format.');
        return Movie.fromMap(doc.data()!);
      }).toList();

      return FavoritesMoviesPage(
        itemList: movies,
        isLastPage: isLastPage,
        lastDocumentSnapshot: lastDocument,
      );
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t remove movie.');
    } on FormatException {
      throw Failure('Bad response format.');
    } catch (e) {
      print(e);
      throw Failure('Unknown error.');
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

  Future<List<int>> getFavoritesIds({required String userId}) async {
    if (userId == '') throw Failure('Unknown user');
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('fav_movies')
          .get();
      return snapshot.docs.map((doc) => doc['id'] as int).toList();
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
        'api_key': _apiKey,
        'language': language,
        'page': page.toString(),
        'include_adult': includeAdult,
        if (query != null) 'query': query,
      },
    );
  }
}
