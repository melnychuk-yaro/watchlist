import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/models/moviesPage.dart';
import 'package:watchlist/data/repositories/auth_repository.dart';

class MoviesRepository {
  static const String apiUri = 'https://api.themoviedb.org/3';
  static const String includeAdult = 'false';
  static const String language = 'en-US';
  final String apiKey = DotEnv().env['TMDB_API_KEY'];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  Future<MoviesPage> getTopRatedMovies({page = 1}) async {
    final response = await http.get(
        '$apiUri/movie/top_rated?api_key=$apiKey&language=$language&page=$page&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      return await _getMoviesPage(response);
    } else {
      throw Exception('Error fetching movies.');
    }
  }

  Future<MoviesPage> getNewMovies({page = 1}) async {
    final response = await http.get(
        '$apiUri/movie/now_playing?api_key=$apiKey&language=$language&page=$page&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      return await _getMoviesPage(response);
    } else {
      throw Exception('Error fetching movies.');
    }
  }

  Future<MoviesPage> searchMovies({String query, int page = 1}) async {
    final response = await http.get(
        '$apiUri/search/movie?api_key=$apiKey&language=$language&query=$query&page=$page&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      return await _getMoviesPage(response);
    } else if (response.statusCode == 422) {
      return MoviesPage(itemList: [], isLastPage: true);
    } else {
      throw Exception(
          'Error fetching movies. Uri: /search/movie. Query: $query');
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
    } catch (e) {
      print(e);
      throw Exception('Saving failed');
    }
  }

  Future<void> removeFavMovie(int id) async {
    try {
      return await firestore
          .collection('users')
          .doc(authenticationRepository.currentUser.id)
          .collection('fav_movies')
          .doc(id.toString())
          .delete();
    } catch (e) {
      print(e);
      throw Exception('Removing failed');
    }
  }

  Future<List<Movie>> getFavMovies() async {
    final snapshot = await firestore
        .collection('users')
        .doc(authenticationRepository.currentUser.id)
        .collection('fav_movies')
        .orderBy('date_added_to_favorite', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Movie.fromMap(doc.data(), isFavorite: true))
        .toList();
  }

  Future<MoviesPage> _getMoviesPage(http.Response response) async {
    try {
      Map<String, dynamic> body = json.decode(response.body);
      List results = body['results'];
      List<int> favIds = await _getFavoritesIds();
      return MoviesPage(
          isLastPage: body['page'] >= body['total_pages'],
          itemList: results.map((movieMap) {
            return Movie.fromMap(
              movieMap,
              isFavorite: favIds.contains(movieMap['id']),
            );
          }).toList());
    } catch (e) {
      print(e);
      throw Exception('Error while getting movies page');
    }
  }

  Future<List<int>> _getFavoritesIds() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(authenticationRepository.currentUser.id)
          .collection('fav_movies')
          .get();
      return snapshot.docs.map((doc) => doc['id'] as int).toList();
    } catch (e) {
      print(e);
      throw Exception('Error fetching faborites IDs');
    }
  }
}
