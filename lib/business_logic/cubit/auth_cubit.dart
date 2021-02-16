import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/data/models/user.dart';
import 'package:watchlist/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository authenticationRepository;
  StreamSubscription _streamSubscription;

  AuthCubit(this.authenticationRepository) : super(AuthInitial()) {
    authenticationRepository.user.listen((User user) {
      emit(
          user == null || user.id == '' ? AuthLoggedOut() : AuthLoggedIn(user));
    }).onError((e) => print(e));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
