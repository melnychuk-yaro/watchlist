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

  _getMoviesPage(http.Response response) {
    Map<String, dynamic> body = json.decode(response.body);
    bool isLastPage = body['page'] < body['total_pages'] ? false : true;
    List results = body['results'];
    return MoviesPage(
        isLastPage: isLastPage,
        itemList: results.map((movieMap) => Movie.fromMap(movieMap)).toList());
  }

  Future<MoviesPage> getTopRatedMovies({page = 1}) async {
    final response = await http.get(
        '$apiUri/movie/top_rated?api_key=$apiKey&language=$language&page=$page&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      return _getMoviesPage(response);
    } else {
      throw Exception('Error fetching movies.');
    }
  }

  Future<MoviesPage> getNewMovies({page = 1}) async {
    final response = await http.get(
        '$apiUri/movie/now_playing?api_key=$apiKey&language=$language&page=$page&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      return _getMoviesPage(response);
    } else {
      throw Exception('Error fetching movies.');
    }
  }

  Future<MoviesPage> searchMovies({String query, int page = 1}) async {
    final response = await http.get(
        '$apiUri/search/movie?api_key=$apiKey&language=$language&query=$query&page=$page&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      return _getMoviesPage(response);
    } else if (response.statusCode == 422) {
      return MoviesPage(itemList: [], isLastPage: true);
    } else {
      throw Exception(
          'Error fetching movies. Uri: /search/movie. Query: $query');
    }
  }

  Future<void> saveFavMovie(Movie movie) async {
    try {
      return await firestore
          .collection('users')
          .doc(authenticationRepository.currentUser.id)
          .collection('fav_movies')
          .doc(movie.id.toString())
          .set(movie.toMap());
    } catch (e) {
      print(e);
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
    }
  }

  Future<List<Movie>> getFavMovies() async {
    final snapshot = await firestore
        .collection('users')
        .doc(authenticationRepository.currentUser.id)
        .collection('fav_movies')
        .get();
    return snapshot.docs
        .map((doc) => Movie.favoriteFromMap(doc.data()))
        .toList();
  }
}
