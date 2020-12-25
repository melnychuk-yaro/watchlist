import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:watchlist/models/movie.dart';

class MoviesProvider {
  static const String apiUri = 'https://api.themoviedb.org/3';
  static const String includeAdult = 'true';
  static const String language = 'en-US';
  final String apiKey = DotEnv().env['TMDB_API_KEY'];

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(
        '$apiUri/movie/top_rated?api_key=$apiKey&language=$language&page=1&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      List results = json.decode(response.body)['results'];
      return results.map((movieMap) {
        return Movie.fromMap(movieMap);
      }).toList();
    } else {
      throw Exception('Error fetching movies.');
    }
  }

  Future<List<Movie>> getNewMovies() async {
    final response = await http.get(
        '$apiUri/movie/now_playing?api_key=$apiKey&language=$language&page=1&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      List results = json.decode(response.body)['results'];
      return results.map((movieMap) {
        return Movie.fromMap(movieMap);
      }).toList();
    } else {
      throw Exception('Error fetching movies.');
    }
  }

  Future<List<Movie>> getFavMovies() async {
    final response = await http.get(
        '$apiUri/movie/now_playing?api_key=$apiKey&language=$language&page=1&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      List results = json.decode(response.body)['results'];
      return results.map((movieMap) {
        return Movie.fromMap(movieMap);
      }).toList();
    } else {
      throw Exception('Error fetching movies.');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
        '$apiUri/search/movie?api_key=$apiKey&language=$language&query=$query&page=1&include_adult=$includeAdult');
    if (response.statusCode == 200) {
      List results = json.decode(response.body)['results'];
      return results.map((movieMap) {
        return Movie.fromMap(movieMap);
      }).toList();
    } else if (response.statusCode == 422) {
      return <Movie>[];
    } else {
      throw Exception(
          'Error fetching movies. Uri: /search/movie. Query: $query');
    }
  }
}
