import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/services/account_decryption_with_password_service.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';
import 'package:kriptum/domain/services/encryption_service.dart';
import 'package:kriptum/domain/services/erc20_token_service.dart';
import 'package:kriptum/domain/services/transaction_service.dart';
import 'package:kriptum/infra/services/services.dart';

Future<void> registerDomainServices() async {
  injector.registerLazySingleton<EncryptionService>(
    () => EncryptionServiceImpl(),
  );
  injector.registerLazySingleton<AccountGeneratorService>(
    () => AccountGeneratorServiceImpl(),
  );
  injector.registerLazySingleton<AccountDecryptionWithPasswordService>(
    () => AccountDecryptionWithPasswordServiceImpl(),
  );
  injector.registerLazySingleton<TransactionService>(
    () => TransactionServiceImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<Erc20TokenService>(
    () => Erc20TokenServiceImpl(
      web3Client: injector.get(),
    ),
  );
}
