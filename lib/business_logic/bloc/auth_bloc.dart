import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/data/models/user.dart';
import 'package:watchlist/data/repositories/auth_repository.dart';
import 'package:pedantic/pedantic.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(const AuthState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<User> _userSubscription;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  AuthState _mapAuthenticationUserChangedToState(
    AuthUserChanged event,
  ) {
    return event.user != User.empty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated();
  }
}
