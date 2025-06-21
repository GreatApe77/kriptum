import 'package:kriptum/domain/models/password.dart';
import 'package:kriptum/shared/contracts/factory.dart';
import 'package:kriptum/shared/utils/result.dart';

abstract interface class PasswordFactory
    implements Factory<String, Password, String> {
  /// Creates a password from the provided [password] string.
  ///
  /// Returns a [Result] containing the created password on success,
  /// or a failure message on error.
  @override
  Result<Password, String> create(String password);
}
