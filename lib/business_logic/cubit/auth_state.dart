part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthLoggedIn extends AuthState {
  final User user;
  const AuthLoggedIn(this.user);
}
