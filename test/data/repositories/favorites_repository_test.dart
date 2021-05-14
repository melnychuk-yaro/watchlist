import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/data/models/favorites_movies_page.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/favorites_repository.dart';

// import 'favorites_repository_test.mocks.dart';

// Mockito can't generate method with generic return types
// the issue https://github.com/dart-lang/mockito/issues/342
// maybe switch to https://pub.dev/packages/mocktail

// @GenerateMocks([
//   FirebaseFirestore,
//   CollectionReference,
//   DocumentReference,
//   Query,
//   QuerySnapshot,
//   QueryDocumentSnapshot,
// ])
void main() {
  // final mockFirestore = MockFirebaseFirestore();
  // final mockCollectionReference = MockCollectionReference();
  // final mockDocumentReference = MockDocumentReference();
  // final mockQuery = MockQuery();
  // final mockQuerySnapshot = MockQuerySnapshot();
  // final mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
  // final repo = FavoritesRepository(firestore: mockFirestore);
  // final defaultMovie = Movie(
  //   id: 42,
  //   title: '42',
  //   releaseDate: '42',
  //   posterFileName: '/42',
  //   rating: 4.2,
  // );

  // group('favorites repository test', () {
  //   when(mockFirestore.collection(any)).thenReturn(mockCollectionReference);
  //   when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
  //   when(mockDocumentReference.collection(any))
  //       .thenReturn(mockCollectionReference);

  //   test('saveFavMovie not throw exceptions', () async {
  //     when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
  //     when(mockDocumentReference.set(any))
  //         .thenAnswer((realInvocation) async => null);

  //     expect(
  //       () async => await repo.saveFavMovie(movie: defaultMovie, userId: '42'),
  //       returnsNormally,
  //     );
  //   });

  //   test('removeFavMovie not throw exceptions', () async {
  //     when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
  //     when(mockDocumentReference.delete())
  //         .thenAnswer((realInvocation) async => null);

  //     expect(
  //       () async => await repo.removeFavMovie(id: 42, userId: '42'),
  //       returnsNormally,
  //     );
  //   });

  //   test('getFavMovies returns Favorite Movies Page', () async {
  //     when(mockCollectionReference.orderBy(
  //       'date_added_to_favorite',
  //       descending: true,
  //     )).thenReturn(mockQuery);
  //     when(mockQuery.limit(any)).thenReturn(mockQuery);
  //     when(mockQuery.get())
  //         .thenAnswer((realInvocation) async => mockQuerySnapshot);
  //     when(mockQuerySnapshot.docs)
  //         .thenReturn(List.filled(1, mockQueryDocumentSnapshot));
  //     when(mockQueryDocumentSnapshot.data()).thenReturn({
  //       'id': 42,
  //       'title': '42',
  //       'release_date': '42',
  //       'poster_path': '/42',
  //       'vote_average': 4.2
  //     });

  //     final favPage = await repo.getFavMovies(userId: '123');
  //     expect(
  //         favPage,
  //         FavoritesMoviesPage(
  //           itemList: [defaultMovie],
  //           isLastPage: true,
  //           lastDocumentSnapshot: mockQueryDocumentSnapshot,
  //         ));
  //   });

  //   test('getFavoritesIds returns  List Of ids', () async {
  //     when(mockCollectionReference.get(any))
  //         .thenAnswer((_) async => mockQuerySnapshot);
  //     when(mockQuerySnapshot.docs)
  //         .thenReturn(List.filled(3, mockQueryDocumentSnapshot));
  //     when(mockQueryDocumentSnapshot.get('id')).thenReturn(42);

  //     final favIds = await repo.getFavoritesIds(userId: '123');
  //     expect(favIds, <int>[42, 42, 42]);
  //   });
  // });
}
