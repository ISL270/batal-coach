import 'package:formz/formz.dart';

enum NameValidationError {
  empty(trKey: 'nameRequired', enMsg: 'Name is required'),

  invalid(trKey: 'nameLettersOnly', enMsg: 'Name must contain letters only');

  const NameValidationError({required this.trKey, required this.enMsg});

  /// Error message to be displayed.
  final String enMsg;
  final String trKey;
}

// Extend FormzInput and provide the input type and error type.
class NameInput extends FormzInput<String, NameValidationError> {
  // Call super.pure to represent an unmodified form input.
  const NameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NameInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  NameValidationError? validator(String value) {
    return value.isEmpty ? NameValidationError.empty : null;
  }
}
