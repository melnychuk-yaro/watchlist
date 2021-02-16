part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

@immutable
class AuthInitial extends AuthState {}

@immutable
class AuthLoggedOut extends AuthState {}

@immutable
class AuthLoggedIn extends AuthState {
  final User user;
  const AuthLoggedIn(this.user);
}
