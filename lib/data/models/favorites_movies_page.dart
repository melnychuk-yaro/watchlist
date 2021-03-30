import 'package:cloud_firestore/cloud_firestore.dart';
import 'movie.dart';
import 'movies_page.dart';

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
