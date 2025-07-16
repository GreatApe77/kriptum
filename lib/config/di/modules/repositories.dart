import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';
import 'package:kriptum/domain/repositories/erc20_token_repository.dart';
import 'package:kriptum/domain/repositories/mnemonic_repository.dart';
import 'package:kriptum/domain/repositories/native_balance_repository.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:kriptum/domain/repositories/password_repository.dart';
import 'package:kriptum/infra/repositories/accounts_repository_impl.dart';
import 'package:kriptum/infra/repositories/contacts_repository_impl.dart';
import 'package:kriptum/infra/repositories/erc20_token_repository_impl.dart';
import 'package:kriptum/infra/repositories/mnemonic_repository_impl.dart';
import 'package:kriptum/infra/repositories/native_balance_repository_impl.dart';
import 'package:kriptum/infra/repositories/networks_repository_impl.dart';
import 'package:kriptum/infra/repositories/password_repository_impl.dart';
import 'package:kriptum/infra/services/erc20_token_service_impl.dart';

Future<void> registerRepositories() async {
  injector.registerLazySingleton<PasswordRepository>(
    () => PasswordRepositoryImpl(),
  );
  injector.registerLazySingleton<AccountsRepository>(
    () => AccountsRepositoryImpl(
      accountsDataSource: injector.get(),
      userPreferences: injector.get(),
    ),
  );
  injector.registerLazySingleton<NetworksRepository>(
    () => NetworksRepositoryImpl(injector.get(), injector.get()),
  );
  injector.registerLazySingleton<NativeBalanceRepository>(
    () => NativeBalanceRepositoryImpl(injector.get(), injector.get()),
  );
  injector.registerLazySingleton<ContactsRepository>(
    () => ContactsRepositoryImpl(injector.get()),
  );
  injector.registerLazySingleton<MnemonicRepository>(
    () => MnemonicRepositoryImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<Erc20TokenRepository>(
    () => Erc20TokenRepositoryImpl(
      injector.get()
    ),
  );
}
