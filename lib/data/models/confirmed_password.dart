import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError { unmatch }

class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String? value) {
    if (pure) return null;
    value = value ?? '';
    return value != password ? ConfirmedPasswordValidationError.unmatch : null;
  }
}
