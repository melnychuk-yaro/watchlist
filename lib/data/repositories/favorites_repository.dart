// import 'dart:io';
import 'package:universal_io/io.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../business_logic/helpers/failures/failure.dart';
import '../models/favorites_movies_page.dart';
import '../models/movie.dart';

class FavoritesRepository {
  final FirebaseFirestore _firestore;

  FavoritesRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveFavMovie(
      {required Movie movie, required String userId}) async {
    try {
      var movieMap = movie.toMap();
      movieMap['date_added_to_favorite'] =
          DateTime.now().millisecondsSinceEpoch;

      return await _firestore
          .collection('users')
          .doc(userId)
          .collection('fav_movies')
          .doc(movie.id.toString())
          .set(movieMap);
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t save movie.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<void> removeFavMovie({required int id, required String userId}) async {
    try {
      return await _firestore
          .collection('users')
          .doc(userId)
          .collection('fav_movies')
          .doc(id.toString())
          .delete();
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t remove movie.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<FavoritesMoviesPage> getFavMovies({
    required String userId,
    DocumentSnapshot? lastDocument,
  }) async {
    QuerySnapshot querySnapshot;
    const limit = 10;
    try {
      querySnapshot = lastDocument == null
          ? await _firestore
              .collection('users')
              .doc(userId)
              .collection('fav_movies')
              .orderBy('date_added_to_favorite', descending: true)
              .limit(limit)
              .get()
          : await _firestore
              .collection('users')
              .doc(userId)
              .collection('fav_movies')
              .orderBy('date_added_to_favorite', descending: true)
              .startAfterDocument(lastDocument)
              .limit(limit)
              .get();

      final isLastPage = querySnapshot.docs.length < limit ? true : false;
      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      final movies = querySnapshot.docs.map((doc) {
        return Movie.fromMap(doc.data());
      }).toList();

      return FavoritesMoviesPage(
        itemList: movies,
        isLastPage: isLastPage,
        lastDocumentSnapshot: lastDocument,
      );
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t remove movie.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }

  Future<List<int>> getFavoritesIds({required String userId}) async {
    if (userId == '') throw Failure('Unknown user');
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('fav_movies')
          .get();
      return snapshot.docs.map((doc) => doc.get('id') as int).toList();
    } on SocketException {
      throw Failure('No internet conneciton.');
    } on HttpException {
      throw Failure('Couldn\'t find movies.');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }
}
