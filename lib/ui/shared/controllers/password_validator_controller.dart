abstract class PasswordValidatorController {
  static const _minimumPasswordLength = 8;
  static String? validLength(String? password) {
    String notNullPassword = password ?? '';
    if (notNullPassword.isEmpty) return 'Required field';
    if (notNullPassword.length < _minimumPasswordLength) return 'Must be at least 8 characters';
    return null;
  }

}
