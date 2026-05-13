import 'package:formz/formz.dart';

enum PasswordValidationError { empty, tooShort }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static const minLength = 6;

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < minLength) return PasswordValidationError.tooShort;
    return null;
  }
}
