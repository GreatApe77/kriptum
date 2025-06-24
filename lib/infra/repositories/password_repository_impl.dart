import 'package:kriptum/domain/repositories/password_repository.dart';

class PasswordRepositoryImpl implements PasswordRepository {
  String _password = '';
  @override
  String getPassword() {
    return _password;
  }

  @override
  void setPassword(String password) {
    _password = password;
  }
}
