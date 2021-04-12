// Mocks generated by Mockito 5.0.3 from annotations
// in watchlist/test/data/repositories/favorites_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:cloud_firestore_platform_interface/src/get_options.dart' as _i7;
import 'package:cloud_firestore_platform_interface/src/persistence_settings.dart'
    as _i6;
import 'package:cloud_firestore_platform_interface/src/set_options.dart' as _i8;
import 'package:cloud_firestore_platform_interface/src/settings.dart' as _i3;
import 'package:firebase_core/firebase_core.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeFirebaseApp extends _i1.Fake implements _i2.FirebaseApp {}

class _FakeSettings extends _i1.Fake implements _i3.Settings {}

class _FakeCollectionReference extends _i1.Fake
    implements _i4.CollectionReference {}

class _FakeWriteBatch extends _i1.Fake implements _i4.WriteBatch {}

class _FakeQuery extends _i1.Fake implements _i4.Query {}

class _FakeDocumentReference extends _i1.Fake implements _i4.DocumentReference {
}

class _FakeFirebaseFirestore extends _i1.Fake implements _i4.FirebaseFirestore {
}

class _FakeQuerySnapshot extends _i1.Fake implements _i4.QuerySnapshot {}

class _FakeDocumentSnapshot extends _i1.Fake implements _i4.DocumentSnapshot {}

class _FakeSnapshotMetadata extends _i1.Fake implements _i4.SnapshotMetadata {}

/// A class which mocks [FirebaseFirestore].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseFirestore extends _i1.Mock implements _i4.FirebaseFirestore {
  MockFirebaseFirestore() {
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
  set settings(_i3.Settings? settings) =>
      super.noSuchMethod(Invocation.setter(#settings, settings),
          returnValueForMissingStub: null);
  @override
  _i3.Settings get settings => (super.noSuchMethod(Invocation.getter(#settings),
      returnValue: _FakeSettings()) as _i3.Settings);
  @override
  int get hashCode =>
      (super.noSuchMethod(Invocation.getter(#hashCode), returnValue: 0) as int);
  @override
  Map<dynamic, dynamic> get pluginConstants =>
      (super.noSuchMethod(Invocation.getter(#pluginConstants),
          returnValue: <dynamic, dynamic>{}) as Map<dynamic, dynamic>);
  @override
  _i4.CollectionReference collection(String? collectionPath) =>
      (super.noSuchMethod(Invocation.method(#collection, [collectionPath]),
          returnValue: _FakeCollectionReference()) as _i4.CollectionReference);
  @override
  _i4.WriteBatch batch() => (super.noSuchMethod(Invocation.method(#batch, []),
      returnValue: _FakeWriteBatch()) as _i4.WriteBatch);
  @override
  _i5.Future<void> clearPersistence() =>
      (super.noSuchMethod(Invocation.method(#clearPersistence, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> enablePersistence(
          [_i6.PersistenceSettings? persistenceSettings]) =>
      (super.noSuchMethod(
          Invocation.method(#enablePersistence, [persistenceSettings]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i4.Query collectionGroup(String? collectionPath) =>
      (super.noSuchMethod(Invocation.method(#collectionGroup, [collectionPath]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i5.Future<void> disableNetwork() =>
      (super.noSuchMethod(Invocation.method(#disableNetwork, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i4.DocumentReference doc(String? documentPath) =>
      (super.noSuchMethod(Invocation.method(#doc, [documentPath]),
          returnValue: _FakeDocumentReference()) as _i4.DocumentReference);
  @override
  _i5.Future<void> enableNetwork() =>
      (super.noSuchMethod(Invocation.method(#enableNetwork, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Stream<void> snapshotsInSync() =>
      (super.noSuchMethod(Invocation.method(#snapshotsInSync, []),
          returnValue: Stream<void>.empty()) as _i5.Stream<void>);
  @override
  _i5.Future<T> runTransaction<T>(_i4.TransactionHandler<T>? transactionHandler,
          {Duration? timeout = const Duration(seconds: 30)}) =>
      (super.noSuchMethod(
          Invocation.method(
              #runTransaction, [transactionHandler], {#timeout: timeout}),
          returnValue: Future.value(null)) as _i5.Future<T>);
  @override
  _i5.Future<void> terminate() =>
      (super.noSuchMethod(Invocation.method(#terminate, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> waitForPendingWrites() =>
      (super.noSuchMethod(Invocation.method(#waitForPendingWrites, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  bool operator ==(Object? other) =>
      (super.noSuchMethod(Invocation.method(#==, [other]), returnValue: false)
          as bool);
  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
}

/// A class which mocks [CollectionReference].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockCollectionReference extends _i1.Mock
    implements _i4.CollectionReference {
  MockCollectionReference() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: '') as String);
  @override
  String get path =>
      (super.noSuchMethod(Invocation.getter(#path), returnValue: '') as String);
  @override
  int get hashCode =>
      (super.noSuchMethod(Invocation.getter(#hashCode), returnValue: 0) as int);
  @override
  _i4.FirebaseFirestore get firestore =>
      (super.noSuchMethod(Invocation.getter(#firestore),
          returnValue: _FakeFirebaseFirestore()) as _i4.FirebaseFirestore);
  @override
  Map<String, dynamic> get parameters =>
      (super.noSuchMethod(Invocation.getter(#parameters),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  _i5.Future<_i4.DocumentReference> add(Map<String, dynamic>? data) =>
      (super.noSuchMethod(Invocation.method(#add, [data]),
              returnValue: Future.value(_FakeDocumentReference()))
          as _i5.Future<_i4.DocumentReference>);
  @override
  _i4.DocumentReference doc([String? path]) =>
      (super.noSuchMethod(Invocation.method(#doc, [path]),
          returnValue: _FakeDocumentReference()) as _i4.DocumentReference);
  @override
  bool operator ==(Object? other) =>
      (super.noSuchMethod(Invocation.method(#==, [other]), returnValue: false)
          as bool);
  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
  @override
  _i4.Query endAtDocument(_i4.DocumentSnapshot? documentSnapshot) =>
      (super.noSuchMethod(Invocation.method(#endAtDocument, [documentSnapshot]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query endAt(List<dynamic>? values) =>
      (super.noSuchMethod(Invocation.method(#endAt, [values]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query endBeforeDocument(_i4.DocumentSnapshot? documentSnapshot) => (super
      .noSuchMethod(Invocation.method(#endBeforeDocument, [documentSnapshot]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query endBefore(List<dynamic>? values) =>
      (super.noSuchMethod(Invocation.method(#endBefore, [values]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i5.Future<_i4.QuerySnapshot> get([_i7.GetOptions? options]) =>
      (super.noSuchMethod(Invocation.method(#get, [options]),
              returnValue: Future.value(_FakeQuerySnapshot()))
          as _i5.Future<_i4.QuerySnapshot>);
  @override
  _i4.Query limit(int? limit) =>
      (super.noSuchMethod(Invocation.method(#limit, [limit]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query limitToLast(int? limit) =>
      (super.noSuchMethod(Invocation.method(#limitToLast, [limit]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i5.Stream<_i4.QuerySnapshot> snapshots(
          {bool? includeMetadataChanges = false}) =>
      (super.noSuchMethod(
              Invocation.method(#snapshots, [],
                  {#includeMetadataChanges: includeMetadataChanges}),
              returnValue: Stream<_i4.QuerySnapshot>.empty())
          as _i5.Stream<_i4.QuerySnapshot>);
  @override
  _i4.Query orderBy(dynamic field, {bool? descending = false}) =>
      (super.noSuchMethod(
          Invocation.method(#orderBy, [field], {#descending: descending}),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query startAfterDocument(_i4.DocumentSnapshot? documentSnapshot) => (super
      .noSuchMethod(Invocation.method(#startAfterDocument, [documentSnapshot]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query startAfter(List<dynamic>? values) =>
      (super.noSuchMethod(Invocation.method(#startAfter, [values]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query startAtDocument(_i4.DocumentSnapshot? documentSnapshot) => (super
      .noSuchMethod(Invocation.method(#startAtDocument, [documentSnapshot]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query startAt(List<dynamic>? values) =>
      (super.noSuchMethod(Invocation.method(#startAt, [values]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query where(dynamic field,
          {dynamic isEqualTo,
          dynamic isNotEqualTo,
          dynamic isLessThan,
          dynamic isLessThanOrEqualTo,
          dynamic isGreaterThan,
          dynamic isGreaterThanOrEqualTo,
          dynamic arrayContains,
          List<dynamic>? arrayContainsAny,
          List<dynamic>? whereIn,
          List<dynamic>? whereNotIn,
          bool? isNull}) =>
      (super.noSuchMethod(
          Invocation.method(#where, [
            field
          ], {
            #isEqualTo: isEqualTo,
            #isNotEqualTo: isNotEqualTo,
            #isLessThan: isLessThan,
            #isLessThanOrEqualTo: isLessThanOrEqualTo,
            #isGreaterThan: isGreaterThan,
            #isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
            #arrayContains: arrayContains,
            #arrayContainsAny: arrayContainsAny,
            #whereIn: whereIn,
            #whereNotIn: whereNotIn,
            #isNull: isNull
          }),
          returnValue: _FakeQuery()) as _i4.Query);
}

/// A class which mocks [DocumentReference].
///
/// See the documentation for Mockito's code generation for more information.
class MockDocumentReference extends _i1.Mock implements _i4.DocumentReference {
  MockDocumentReference() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.FirebaseFirestore get firestore =>
      (super.noSuchMethod(Invocation.getter(#firestore),
          returnValue: _FakeFirebaseFirestore()) as _i4.FirebaseFirestore);
  @override
  String get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: '') as String);
  @override
  _i4.CollectionReference get parent =>
      (super.noSuchMethod(Invocation.getter(#parent),
          returnValue: _FakeCollectionReference()) as _i4.CollectionReference);
  @override
  String get path =>
      (super.noSuchMethod(Invocation.getter(#path), returnValue: '') as String);
  @override
  int get hashCode =>
      (super.noSuchMethod(Invocation.getter(#hashCode), returnValue: 0) as int);
  @override
  _i4.CollectionReference collection(String? collectionPath) =>
      (super.noSuchMethod(Invocation.method(#collection, [collectionPath]),
          returnValue: _FakeCollectionReference()) as _i4.CollectionReference);
  @override
  _i5.Future<void> delete() =>
      (super.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<_i4.DocumentSnapshot> get([_i7.GetOptions? options]) =>
      (super.noSuchMethod(Invocation.method(#get, [options]),
              returnValue: Future.value(_FakeDocumentSnapshot()))
          as _i5.Future<_i4.DocumentSnapshot>);
  @override
  _i5.Stream<_i4.DocumentSnapshot> snapshots(
          {bool? includeMetadataChanges = false}) =>
      (super.noSuchMethod(
              Invocation.method(#snapshots, [],
                  {#includeMetadataChanges: includeMetadataChanges}),
              returnValue: Stream<_i4.DocumentSnapshot>.empty())
          as _i5.Stream<_i4.DocumentSnapshot>);
  @override
  _i5.Future<void> set(Map<String, dynamic>? data, [_i8.SetOptions? options]) =>
      (super.noSuchMethod(Invocation.method(#set, [data, options]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> update(Map<String, dynamic>? data) =>
      (super.noSuchMethod(Invocation.method(#update, [data]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  bool operator ==(Object? other) =>
      (super.noSuchMethod(Invocation.method(#==, [other]), returnValue: false)
          as bool);
  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
}

/// A class which mocks [Query].
///
/// See the documentation for Mockito's code generation for more information.
class MockQuery extends _i1.Mock implements _i4.Query {
  MockQuery() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.FirebaseFirestore get firestore =>
      (super.noSuchMethod(Invocation.getter(#firestore),
          returnValue: _FakeFirebaseFirestore()) as _i4.FirebaseFirestore);
  @override
  Map<String, dynamic> get parameters =>
      (super.noSuchMethod(Invocation.getter(#parameters),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  _i4.Query endAtDocument(_i4.DocumentSnapshot? documentSnapshot) =>
      (super.noSuchMethod(Invocation.method(#endAtDocument, [documentSnapshot]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query endAt(List<dynamic>? values) =>
      (super.noSuchMethod(Invocation.method(#endAt, [values]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query endBeforeDocument(_i4.DocumentSnapshot? documentSnapshot) => (super
      .noSuchMethod(Invocation.method(#endBeforeDocument, [documentSnapshot]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query endBefore(List<dynamic>? values) =>
      (super.noSuchMethod(Invocation.method(#endBefore, [values]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i5.Future<_i4.QuerySnapshot> get([_i7.GetOptions? options]) =>
      (super.noSuchMethod(Invocation.method(#get, [options]),
              returnValue: Future.value(_FakeQuerySnapshot()))
          as _i5.Future<_i4.QuerySnapshot>);
  @override
  _i4.Query limit(int? limit) =>
      (super.noSuchMethod(Invocation.method(#limit, [limit]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query limitToLast(int? limit) =>
      (super.noSuchMethod(Invocation.method(#limitToLast, [limit]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i5.Stream<_i4.QuerySnapshot> snapshots(
          {bool? includeMetadataChanges = false}) =>
      (super.noSuchMethod(
              Invocation.method(#snapshots, [],
                  {#includeMetadataChanges: includeMetadataChanges}),
              returnValue: Stream<_i4.QuerySnapshot>.empty())
          as _i5.Stream<_i4.QuerySnapshot>);
  @override
  _i4.Query orderBy(dynamic field, {bool? descending = false}) =>
      (super.noSuchMethod(
          Invocation.method(#orderBy, [field], {#descending: descending}),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query startAfterDocument(_i4.DocumentSnapshot? documentSnapshot) => (super
      .noSuchMethod(Invocation.method(#startAfterDocument, [documentSnapshot]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query startAfter(List<dynamic>? values) =>
      (super.noSuchMethod(Invocation.method(#startAfter, [values]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query startAtDocument(_i4.DocumentSnapshot? documentSnapshot) => (super
      .noSuchMethod(Invocation.method(#startAtDocument, [documentSnapshot]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query startAt(List<dynamic>? values) =>
      (super.noSuchMethod(Invocation.method(#startAt, [values]),
          returnValue: _FakeQuery()) as _i4.Query);
  @override
  _i4.Query where(dynamic field,
          {dynamic isEqualTo,
          dynamic isNotEqualTo,
          dynamic isLessThan,
          dynamic isLessThanOrEqualTo,
          dynamic isGreaterThan,
          dynamic isGreaterThanOrEqualTo,
          dynamic arrayContains,
          List<dynamic>? arrayContainsAny,
          List<dynamic>? whereIn,
          List<dynamic>? whereNotIn,
          bool? isNull}) =>
      (super.noSuchMethod(
          Invocation.method(#where, [
            field
          ], {
            #isEqualTo: isEqualTo,
            #isNotEqualTo: isNotEqualTo,
            #isLessThan: isLessThan,
            #isLessThanOrEqualTo: isLessThanOrEqualTo,
            #isGreaterThan: isGreaterThan,
            #isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
            #arrayContains: arrayContains,
            #arrayContainsAny: arrayContainsAny,
            #whereIn: whereIn,
            #whereNotIn: whereNotIn,
            #isNull: isNull
          }),
          returnValue: _FakeQuery()) as _i4.Query);
}

/// A class which mocks [QuerySnapshot].
///
/// See the documentation for Mockito's code generation for more information.
class MockQuerySnapshot extends _i1.Mock implements _i4.QuerySnapshot {
  MockQuerySnapshot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i4.QueryDocumentSnapshot> get docs =>
      (super.noSuchMethod(Invocation.getter(#docs),
              returnValue: <_i4.QueryDocumentSnapshot>[])
          as List<_i4.QueryDocumentSnapshot>);
  @override
  List<_i4.DocumentChange> get docChanges =>
      (super.noSuchMethod(Invocation.getter(#docChanges),
          returnValue: <_i4.DocumentChange>[]) as List<_i4.DocumentChange>);
  @override
  _i4.SnapshotMetadata get metadata =>
      (super.noSuchMethod(Invocation.getter(#metadata),
          returnValue: _FakeSnapshotMetadata()) as _i4.SnapshotMetadata);
  @override
  int get size =>
      (super.noSuchMethod(Invocation.getter(#size), returnValue: 0) as int);
}

/// A class which mocks [QueryDocumentSnapshot].
///
/// See the documentation for Mockito's code generation for more information.
class MockQueryDocumentSnapshot extends _i1.Mock
    implements _i4.QueryDocumentSnapshot {
  MockQueryDocumentSnapshot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get exists =>
      (super.noSuchMethod(Invocation.getter(#exists), returnValue: false)
          as bool);
  @override
  String get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: '') as String);
  @override
  _i4.DocumentReference get reference =>
      (super.noSuchMethod(Invocation.getter(#reference),
          returnValue: _FakeDocumentReference()) as _i4.DocumentReference);
  @override
  _i4.SnapshotMetadata get metadata =>
      (super.noSuchMethod(Invocation.getter(#metadata),
          returnValue: _FakeSnapshotMetadata()) as _i4.SnapshotMetadata);
  @override
  Map<String, dynamic> data() =>
      (super.noSuchMethod(Invocation.method(#data, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}
