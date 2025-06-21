import 'package:kriptum/domain/factories/password_factory.dart';
import 'package:kriptum/domain/models/password.dart';
import 'package:kriptum/shared/utils/result.dart';

class PasswordFactoryImpl implements PasswordFactory {
  @override
  Result<Password, String> create(String password) {
    try {
      final passwordInstance = Password(password);
      return Result.success(passwordInstance);
    } on ArgumentError catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('An unexpected error occurred: ${e.toString()}');
    }
  }
}
