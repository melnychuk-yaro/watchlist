import 'package:flutter/foundation.dart';
import 'movie.dart';

@immutable
class MoviesPage {
  final List<Movie> itemList;
  final bool isLastPage;

  MoviesPage({
    required this.itemList,
    required this.isLastPage,
  });
}
