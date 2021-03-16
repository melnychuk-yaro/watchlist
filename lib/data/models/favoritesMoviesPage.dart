import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/models/moviesPage.dart';

class FavoritesMoviesPage extends MoviesPage {
  final List<Movie> itemList;
  final bool isLastPage;
  final DocumentSnapshot? lastDocumentSnapshot;

  FavoritesMoviesPage({
    required this.itemList,
    required this.isLastPage,
    required this.lastDocumentSnapshot,
  }) : super(isLastPage: isLastPage, itemList: itemList);
}
