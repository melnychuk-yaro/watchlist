import 'failure.dart';

class AuthFailure extends Failure {
  final String message;
  const AuthFailure([this.message = 'Unknown error']) : super(message);
}
