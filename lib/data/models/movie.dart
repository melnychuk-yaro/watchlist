import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final String poster;
  final double rating;
  static const imgPath = 'https://image.tmdb.org/t/p/w500';

  Movie({
    @required this.id,
    @required this.title,
    @required this.releaseDate,
    @required this.poster,
    @required this.rating,
  });

  factory Movie.fromMap(Map<String, dynamic> movieMap) {
    return Movie(
      id: movieMap['id'],
      title: movieMap['title'],
      releaseDate: movieMap['release_date'] ?? '',
      poster:
          movieMap['poster_path'] == null || movieMap['poster_path'] == 'null'
              ? Placeholder()
              : imgPath + movieMap['poster_path'],
      rating:
          movieMap['vote_average'] == null || movieMap['vote_average'] == 'null'
              ? 0.0
              : movieMap['vote_average'].toDouble(),
    );
  }

  factory Movie.fromSnapshot(QueryDocumentSnapshot movieSnapshot) {
    return Movie(
      id: movieSnapshot['id'],
      title: movieSnapshot['title'],
      releaseDate: movieSnapshot['release_date'] ?? '',
      poster:
          movieSnapshot['poster'] == null || movieSnapshot['poster'] == 'null'
              ? Placeholder()
              : movieSnapshot['poster'],
      rating:
          movieSnapshot['rating'] == null || movieSnapshot['rating'] == 'null'
              ? 0.0
              : movieSnapshot['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'release_date': this.releaseDate,
      'poster': this.poster,
      'rating': this.rating
    };
  }
}
