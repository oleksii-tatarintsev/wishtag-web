// ignore_for_file: unnecessary_string_escapes

class Validator {
  static String? validateEmail(String? value) {

    if (value != null) {
      final regExp = RegExp(
        '^[a-zA-Z0-9._-]{1,30}[@]([a-zA-Z0-9]{1,30}[.]{0,1}[a-zA-Z0-9]{1,30}){1,3}[.][a-zA-Z]{1,4}',
      );

      if (!regExp.hasMatch(value)) {
        return 'loc_validator_wrong_email';
      }
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'loc_validator_password_empty';
      }
      if (value.length < 8 || value.length > 32) {
        return 'loc_validator_password_length';
      }
    }

    return null;
  }
}
