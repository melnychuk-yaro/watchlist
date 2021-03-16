import 'package:flutter/material.dart';

@immutable
class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final double rating;
  final String posterFileName;
  static const posterPath = 'https://image.tmdb.org/t/p/w500';

  const Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterFileName,
    required this.rating,
  });

  String get fullPosterPath => posterPath + posterFileName;

  factory Movie.fromMap(Map<String, dynamic> movieMap) {
    return Movie(
      id: movieMap['id'],
      title: movieMap['title'],
      releaseDate: movieMap['release_date'] ?? '',
      posterFileName: movieMap['poster_path'] == null ||
              movieMap['poster_path'] == 'null' ||
              movieMap['poster_path'] == ''
          ? ''
          : movieMap['poster_path'],
      rating:
          movieMap['vote_average'] == null || movieMap['vote_average'] == 'null'
              ? 0.0
              : movieMap['vote_average'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'release_date': this.releaseDate,
      'poster_path': this.posterFileName,
      'vote_average': this.rating
    };
  }

  Movie copyWith({
    int? id,
    String? title,
    String? releaseDate,
    String? posterFileName,
    double? rating,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      posterFileName: posterFileName ?? this.posterFileName,
      rating: rating ?? this.rating,
    );
  }
}
