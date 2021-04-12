import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'movie.dart';

@immutable
class MoviesPage extends Equatable {
  final List<Movie> itemList;
  final bool isLastPage;

  MoviesPage({
    required this.itemList,
    required this.isLastPage,
  });

  @override
  List<Object> get props => [itemList, isLastPage];
}
