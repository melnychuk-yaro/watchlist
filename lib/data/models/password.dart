import 'package:formz/formz.dart';

enum PasswordValidationError { short }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if (pure) return null;
    value = value ?? '';
    return value.length < 6 ? PasswordValidationError.short : null;
  }
}
