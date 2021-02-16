import 'package:flutter/foundation.dart';
import 'package:watchlist/data/models/movie.dart';

@immutable
class MoviesPage {
  final List<Movie> itemList;
  final bool isLastPage;

  MoviesPage({@required this.itemList, this.isLastPage});
}
