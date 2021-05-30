// Mocks generated by Mockito 5.0.9 from annotations
// in watchlist/test/data/repositories/auth_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;

import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_auth_platform_interface/src/action_code_info.dart'
    as _i3;
import 'package:firebase_auth_platform_interface/src/action_code_settings.dart'
    as _i8;
import 'package:firebase_auth_platform_interface/src/auth_credential.dart'
    as _i10;
import 'package:firebase_auth_platform_interface/src/auth_provider.dart'
    as _i11;
import 'package:firebase_auth_platform_interface/src/id_token_result.dart'
    as _i6;
import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart'
    as _i13;
import 'package:firebase_auth_platform_interface/src/types.dart' as _i9;
import 'package:firebase_auth_platform_interface/src/user_info.dart' as _i12;
import 'package:firebase_auth_platform_interface/src/user_metadata.dart' as _i5;
import 'package:firebase_core/firebase_core.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeFirebaseApp extends _i1.Fake implements _i2.FirebaseApp {}

class _FakeActionCodeInfo extends _i1.Fake implements _i3.ActionCodeInfo {}

class _FakeUserCredential extends _i1.Fake implements _i4.UserCredential {}

class _FakeConfirmationResult extends _i1.Fake
    implements _i4.ConfirmationResult {}

class _FakeUserMetadata extends _i1.Fake implements _i5.UserMetadata {}

class _FakeIdTokenResult extends _i1.Fake implements _i6.IdTokenResult {}

class _FakeUser extends _i1.Fake implements _i4.User {}

/// A class which mocks [FirebaseAuth].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseAuth extends _i1.Mock implements _i4.FirebaseAuth {
  MockFirebaseAuth() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FirebaseApp get app => (super.noSuchMethod(Invocation.getter(#app),
      returnValue: _FakeFirebaseApp()) as _i2.FirebaseApp);
  @override
  set app(_i2.FirebaseApp? _app) =>
      super.noSuchMethod(Invocation.setter(#app, _app),
          returnValueForMissingStub: null);
  @override
  Map<dynamic, dynamic> get pluginConstants =>
      (super.noSuchMethod(Invocation.getter(#pluginConstants),
          returnValue: <dynamic, dynamic>{}) as Map<dynamic, dynamic>);
  @override
  _i7.Future<void> useEmulator(String? origin) =>
      (super.noSuchMethod(Invocation.method(#useEmulator, [origin]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> applyActionCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#applyActionCode, [code]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<_i3.ActionCodeInfo> checkActionCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#checkActionCode, [code]),
              returnValue:
                  Future<_i3.ActionCodeInfo>.value(_FakeActionCodeInfo()))
          as _i7.Future<_i3.ActionCodeInfo>);
  @override
  _i7.Future<void> confirmPasswordReset({String? code, String? newPassword}) =>
      (super.noSuchMethod(
          Invocation.method(#confirmPasswordReset, [],
              {#code: code, #newPassword: newPassword}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<_i4.UserCredential> createUserWithEmailAndPassword(
          {String? email, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#createUserWithEmailAndPassword, [],
                  {#email: email, #password: password}),
              returnValue:
                  Future<_i4.UserCredential>.value(_FakeUserCredential()))
          as _i7.Future<_i4.UserCredential>);
  @override
  _i7.Future<List<String>> fetchSignInMethodsForEmail(String? email) => (super
          .noSuchMethod(Invocation.method(#fetchSignInMethodsForEmail, [email]),
              returnValue: Future<List<String>>.value(<String>[]))
      as _i7.Future<List<String>>);
  @override
  _i7.Future<_i4.UserCredential> getRedirectResult() => (super.noSuchMethod(
          Invocation.method(#getRedirectResult, []),
          returnValue: Future<_i4.UserCredential>.value(_FakeUserCredential()))
      as _i7.Future<_i4.UserCredential>);
  @override
  bool isSignInWithEmailLink(String? emailLink) => (super.noSuchMethod(
      Invocation.method(#isSignInWithEmailLink, [emailLink]),
      returnValue: false) as bool);
  @override
  _i7.Stream<_i4.User?> authStateChanges() =>
      (super.noSuchMethod(Invocation.method(#authStateChanges, []),
          returnValue: Stream<_i4.User?>.empty()) as _i7.Stream<_i4.User?>);
  @override
  _i7.Stream<_i4.User?> idTokenChanges() =>
      (super.noSuchMethod(Invocation.method(#idTokenChanges, []),
          returnValue: Stream<_i4.User?>.empty()) as _i7.Stream<_i4.User?>);
  @override
  _i7.Stream<_i4.User?> userChanges() =>
      (super.noSuchMethod(Invocation.method(#userChanges, []),
          returnValue: Stream<_i4.User?>.empty()) as _i7.Stream<_i4.User?>);
  @override
  _i7.Future<void> sendPasswordResetEmail(
          {String? email, _i8.ActionCodeSettings? actionCodeSettings}) =>
      (super.noSuchMethod(
          Invocation.method(#sendPasswordResetEmail, [],
              {#email: email, #actionCodeSettings: actionCodeSettings}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> sendSignInLinkToEmail(
          {String? email, _i8.ActionCodeSettings? actionCodeSettings}) =>
      (super.noSuchMethod(
          Invocation.method(#sendSignInLinkToEmail, [],
              {#email: email, #actionCodeSettings: actionCodeSettings}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> setLanguageCode(String? languageCode) =>
      (super.noSuchMethod(Invocation.method(#setLanguageCode, [languageCode]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> setSettings(
          {bool? appVerificationDisabledForTesting, String? userAccessGroup}) =>
      (super.noSuchMethod(
          Invocation.method(#setSettings, [], {
            #appVerificationDisabledForTesting:
                appVerificationDisabledForTesting,
            #userAccessGroup: userAccessGroup
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> setPersistence(_i9.Persistence? persistence) =>
      (super.noSuchMethod(Invocation.method(#setPersistence, [persistence]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<_i4.UserCredential> signInAnonymously() => (super.noSuchMethod(
          Invocation.method(#signInAnonymously, []),
          returnValue: Future<_i4.UserCredential>.value(_FakeUserCredential()))
      as _i7.Future<_i4.UserCredential>);
  @override
  _i7.Future<_i4.UserCredential> signInWithCredential(
          _i10.AuthCredential? credential) =>
      (super.noSuchMethod(
              Invocation.method(#signInWithCredential, [credential]),
              returnValue:
                  Future<_i4.UserCredential>.value(_FakeUserCredential()))
          as _i7.Future<_i4.UserCredential>);
  @override
  _i7.Future<_i4.UserCredential> signInWithCustomToken(String? token) =>
      (super.noSuchMethod(Invocation.method(#signInWithCustomToken, [token]),
              returnValue:
                  Future<_i4.UserCredential>.value(_FakeUserCredential()))
          as _i7.Future<_i4.UserCredential>);
  @override
  _i7.Future<_i4.UserCredential> signInWithEmailAndPassword(
          {String? email, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#signInWithEmailAndPassword, [],
                  {#email: email, #password: password}),
              returnValue:
                  Future<_i4.UserCredential>.value(_FakeUserCredential()))
          as _i7.Future<_i4.UserCredential>);
  @override
  _i7.Future<_i4.UserCredential> signInWithEmailLink(
          {String? email, String? emailLink}) =>
      (super.noSuchMethod(
          Invocation.method(
              #signInWithEmailLink, [], {#email: email, #emailLink: emailLink}),
          returnValue:
              Future<_i4.UserCredential>.value(_FakeUserCredential())) as _i7
          .Future<_i4.UserCredential>);
  @override
  _i7.Future<_i4.ConfirmationResult> signInWithPhoneNumber(String? phoneNumber,
          [_i4.RecaptchaVerifier? verifier]) =>
      (super.noSuchMethod(
          Invocation.method(#signInWithPhoneNumber, [phoneNumber, verifier]),
          returnValue: Future<_i4.ConfirmationResult>.value(
              _FakeConfirmationResult())) as _i7
          .Future<_i4.ConfirmationResult>);
  @override
  _i7.Future<_i4.UserCredential> signInWithPopup(_i11.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#signInWithPopup, [provider]),
              returnValue:
                  Future<_i4.UserCredential>.value(_FakeUserCredential()))
          as _i7.Future<_i4.UserCredential>);
  @override
  _i7.Future<void> signInWithRedirect(_i11.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#signInWithRedirect, [provider]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<String> verifyPasswordResetCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#verifyPasswordResetCode, [code]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<void> verifyPhoneNumber(
          {String? phoneNumber,
          _i9.PhoneVerificationCompleted? verificationCompleted,
          _i9.PhoneVerificationFailed? verificationFailed,
          _i9.PhoneCodeSent? codeSent,
          _i9.PhoneCodeAutoRetrievalTimeout? codeAutoRetrievalTimeout,
          String? autoRetrievedSmsCodeForTesting,
          Duration? timeout = const Duration(seconds: 30),
          int? forceResendingToken}) =>
      (super.noSuchMethod(
          Invocation.method(#verifyPhoneNumber, [], {
            #phoneNumber: phoneNumber,
            #verificationCompleted: verificationCompleted,
            #verificationFailed: verificationFailed,
            #codeSent: codeSent,
            #codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
            #autoRetrievedSmsCodeForTesting: autoRetrievedSmsCodeForTesting,
            #timeout: timeout,
            #forceResendingToken: forceResendingToken
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
}

/// A class which mocks [UserCredential].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserCredential extends _i1.Mock implements _i4.UserCredential {
  MockUserCredential() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
}

/// A class which mocks [User].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseUser extends _i1.Mock implements _i4.User {
  MockFirebaseUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get emailVerified =>
      (super.noSuchMethod(Invocation.getter(#emailVerified), returnValue: false)
          as bool);
  @override
  bool get isAnonymous =>
      (super.noSuchMethod(Invocation.getter(#isAnonymous), returnValue: false)
          as bool);
  @override
  _i5.UserMetadata get metadata =>
      (super.noSuchMethod(Invocation.getter(#metadata),
          returnValue: _FakeUserMetadata()) as _i5.UserMetadata);
  @override
  List<_i12.UserInfo> get providerData =>
      (super.noSuchMethod(Invocation.getter(#providerData),
          returnValue: <_i12.UserInfo>[]) as List<_i12.UserInfo>);
  @override
  String get uid =>
      (super.noSuchMethod(Invocation.getter(#uid), returnValue: '') as String);
  @override
  _i7.Future<void> delete() =>
      (super.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<String> getIdToken([bool? forceRefresh = false]) =>
      (super.noSuchMethod(Invocation.method(#getIdToken, [forceRefresh]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i6.IdTokenResult> getIdTokenResult(
          [bool? forceRefresh = false]) =>
      (super.noSuchMethod(Invocation.method(#getIdTokenResult, [forceRefresh]),
              returnValue:
                  Future<_i6.IdTokenResult>.value(_FakeIdTokenResult()))
          as _i7.Future<_i6.IdTokenResult>);
  @override
  _i7.Future<_i4.UserCredential> linkWithCredential(
          _i10.AuthCredential? credential) =>
      (super.noSuchMethod(Invocation.method(#linkWithCredential, [credential]),
              returnValue:
                  Future<_i4.UserCredential>.value(_FakeUserCredential()))
          as _i7.Future<_i4.UserCredential>);
  @override
  _i7.Future<_i4.ConfirmationResult> linkWithPhoneNumber(String? phoneNumber,
          [_i4.RecaptchaVerifier? verifier]) =>
      (super.noSuchMethod(
              Invocation.method(#linkWithPhoneNumber, [phoneNumber, verifier]),
              returnValue: Future<_i4.ConfirmationResult>.value(
                  _FakeConfirmationResult()))
          as _i7.Future<_i4.ConfirmationResult>);
  @override
  _i7.Future<_i4.UserCredential> reauthenticateWithCredential(
          _i10.AuthCredential? credential) =>
      (super.noSuchMethod(
              Invocation.method(#reauthenticateWithCredential, [credential]),
              returnValue:
                  Future<_i4.UserCredential>.value(_FakeUserCredential()))
          as _i7.Future<_i4.UserCredential>);
  @override
  _i7.Future<void> reload() =>
      (super.noSuchMethod(Invocation.method(#reload, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> sendEmailVerification(
          [_i8.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(
          Invocation.method(#sendEmailVerification, [actionCodeSettings]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<_i4.User> unlink(String? providerId) =>
      (super.noSuchMethod(Invocation.method(#unlink, [providerId]),
              returnValue: Future<_i4.User>.value(_FakeUser()))
          as _i7.Future<_i4.User>);
  @override
  _i7.Future<void> updateEmail(String? newEmail) =>
      (super.noSuchMethod(Invocation.method(#updateEmail, [newEmail]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> updatePassword(String? newPassword) =>
      (super.noSuchMethod(Invocation.method(#updatePassword, [newPassword]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> updatePhoneNumber(
          _i13.PhoneAuthCredential? phoneCredential) =>
      (super.noSuchMethod(
          Invocation.method(#updatePhoneNumber, [phoneCredential]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> updateProfile({String? displayName, String? photoURL}) =>
      (super.noSuchMethod(
          Invocation.method(#updateProfile, [],
              {#displayName: displayName, #photoURL: photoURL}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> verifyBeforeUpdateEmail(String? newEmail,
          [_i8.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(
          Invocation.method(
              #verifyBeforeUpdateEmail, [newEmail, actionCodeSettings]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i7.Future<void>);
  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
}
