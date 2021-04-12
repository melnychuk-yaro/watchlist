import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/business_logic/helpers/failures/auth_failure.dart';
import 'package:watchlist/data/models/user.dart';
import 'package:watchlist/data/repositories/auth_repository.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks(
  [
    firebase_auth.FirebaseAuth,
    firebase_auth.UserCredential,
  ],
  customMocks: [
    MockSpec<firebase_auth.User>(as: #MockFirebaseUser),
  ],
)
void main() {
  final mockFirebaseAuth = MockFirebaseAuth();
  final authRepo = AuthenticationRepository(firebaseAuth: mockFirebaseAuth);
  final mockFirebaseUser = MockFirebaseUser();
  final mockUserCredential = MockUserCredential();

  group('user repository test', () {
    when(mockFirebaseUser.uid).thenReturn('123');
    when(mockFirebaseUser.email).thenReturn('test@gmail.com');
    when(mockFirebaseUser.displayName).thenReturn(null);
    when(mockFirebaseUser.photoURL).thenReturn(null);
    when(mockFirebaseAuth.authStateChanges()).thenAnswer(
      (realInvocation) => Stream.fromIterable([
        null,
        mockFirebaseUser,
        null,
      ]),
    );

    test('users changed', () async {
      expectLater(
        authRepo.user,
        await emitsInOrder([
          User.empty,
          User(id: '123', email: 'test@gmail.com'),
          User.empty,
        ]),
      );
    });

    test('create account', () {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@gmail.com',
        password: '123456',
      )).thenAnswer((realInvocation) async => mockUserCredential);

      expect(
        () async => await authRepo.signUp(
          email: 'test@gmail.com',
          password: '123456',
        ),
        returnsNormally,
      );
    });

    test('create account throws exeption', () {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@gmail.com',
        password: '123',
      )).thenThrow(
        firebase_auth.FirebaseAuthException(
          code: 'ERROR_WEAK_PASSWORD',
          message: 'weak pasword',
        ),
      );

      expect(
        () async => await authRepo.signUp(
          email: 'test@gmail.com',
          password: '123',
        ),
        throwsA((e) => e is AuthFailure),
      );
    });

    test('log in', () {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@gmail.com',
        password: '123456',
      )).thenAnswer((realInvocation) async => mockUserCredential);

      expect(
        () async => await authRepo.logInWithEmailAndPassword(
          email: 'test@gmail.com',
          password: '123456',
        ),
        returnsNormally,
      );
    });

    test('log in throws exeption', () {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@gmail.com',
        password: '123',
      )).thenThrow(
        firebase_auth.FirebaseAuthException(
          code: 'ERROR_WRONG_PASSWORD',
          message: 'wrong pasword',
        ),
      );

      expect(
        () async => await authRepo.logInWithEmailAndPassword(
          email: 'test@gmail.com',
          password: '123',
        ),
        throwsA((e) => e is AuthFailure),
      );
    });
  });
}
