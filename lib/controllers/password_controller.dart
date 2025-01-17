class PasswordController {
  String _password = '';

  String get password => _password;

  void setPassord(String password) {
    _password = password;
  }

  void clearPassword() {
    _password = '';
  }
}
