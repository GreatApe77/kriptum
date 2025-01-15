class PasswordController {
  String _password = '';

  get password => _password;

  void setPassord(String password) {
    _password = password;
  }

  void clearPassword() {
    _password = '';
  }
}
