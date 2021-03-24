part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMsg = '',
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String errorMsg;

  @override
  List<Object> get props => [email, password, status, errorMsg];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMsg,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
