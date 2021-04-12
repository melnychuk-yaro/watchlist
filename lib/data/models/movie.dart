import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Movie extends Equatable {
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

  @override
  List<Object> get props => [id, title, releaseDate, rating, posterFileName];

  String get fullPosterPath => posterPath + posterFileName;

  factory Movie.fromMap(Map<String, dynamic> movieMap) {
    return Movie(
      id: movieMap['id'],
      title: movieMap['title'],
      releaseDate: movieMap['release_date'] ?? '',
      posterFileName:
          movieMap['poster_path'] == null || movieMap['poster_path'] == 'null'
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
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'poster_path': posterFileName,
      'vote_average': rating
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
