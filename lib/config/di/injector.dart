import 'package:get_it/get_it.dart';
import 'package:kriptum/domain/factories/ethereum_address_factory.dart';
import 'package:kriptum/domain/factories/mnemonic_factory.dart';
import 'package:kriptum/domain/factories/password_factory.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';
import 'package:kriptum/domain/repositories/mnemonic_repository.dart';
import 'package:kriptum/domain/repositories/native_balance_repository.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:kriptum/domain/repositories/password_repository.dart';
import 'package:kriptum/domain/services/account_decryption_with_password_service.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';
import 'package:kriptum/domain/services/encryption_service.dart';
import 'package:kriptum/domain/usecases/add_contact_usecase.dart';
import 'package:kriptum/domain/usecases/add_hd_wallet_account_usecase.dart';
import 'package:kriptum/domain/usecases/confirm_and_save_generated_accounts_usecase.dart';
import 'package:kriptum/domain/usecases/generate_accounts_preview_usecase.dart';
import 'package:kriptum/domain/usecases/get_native_balance_of_account_usecase.dart';
import 'package:kriptum/domain/usecases/import_wallet_usecase.dart';
import 'package:kriptum/domain/usecases/reset_wallet_usecase.dart';
import 'package:kriptum/domain/usecases/unlock_wallet_usecase.dart';
import 'package:kriptum/infra/datasources/accounts_data_source.dart';
import 'package:kriptum/infra/datasources/accounts_data_source_impl.dart';
import 'package:kriptum/infra/datasources/contacts_data_source.dart';
import 'package:kriptum/infra/datasources/contacts_data_source_impl.dart';
import 'package:kriptum/infra/datasources/native_balance_data_source.dart';
import 'package:kriptum/infra/datasources/native_balance_data_source_impl.dart';
import 'package:kriptum/infra/datasources/networks_data_source.dart';
import 'package:kriptum/infra/datasources/networks_data_source_impl.dart';
import 'package:kriptum/infra/factories/ethereum_address_factory_impl.dart';
import 'package:kriptum/infra/factories/mnemonic_factory_impl.dart';
import 'package:kriptum/infra/factories/password_factory_impl.dart';
import 'package:kriptum/infra/persistence/user_preferences/shared_preferences/user_preferences_impl.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';
import 'package:kriptum/infra/repositories/accounts_repository_impl.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';
import 'package:kriptum/infra/persistence/database/sqflite/sqflite_database.dart';
import 'package:kriptum/infra/repositories/contacts_repository_impl.dart';
import 'package:kriptum/infra/repositories/mnemonic_repository_impl.dart';
import 'package:kriptum/infra/repositories/native_balance_repository_impl.dart';
import 'package:kriptum/infra/repositories/networks_repository_impl.dart';
import 'package:kriptum/infra/repositories/password_repository_impl.dart';
import 'package:kriptum/infra/services/account_decryption_with_password_service_impl.dart';
import 'package:kriptum/infra/services/account_generator_service_impl.dart';
import 'package:kriptum/infra/services/encryption_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final injector = GetIt.instance;
Future<void> initInjector() async {
  injector.registerLazySingleton<SqlDatabase>(
    () => SqfliteDatabase(),
  );
  injector.registerLazySingleton<AccountGeneratorService>(
    () => AccountGeneratorServiceImpl(),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton<UserPreferences>(
    () => UserPreferencesImpl(
      sharedPreferences: sharedPreferences,
    ),
  );
  injector.registerLazySingleton<PasswordRepository>(
    () => PasswordRepositoryImpl(),
  );
  injector.registerLazySingleton<AccountsDataSource>(
    () => AccountsDataSourceImpl(
      sqlDatabase: injector.get(),
    ),
  );
  injector.registerLazySingleton<AccountsRepository>(
    () => AccountsRepositoryImpl(
      accountsDataSource: injector.get(),
      userPreferences: injector.get(),
    ),
  );
  injector.registerLazySingleton<GenerateAccountsPreviewUsecase>(
    () => GenerateAccountsPreviewUsecase(
        accountGenerator: injector.get(), passwordRepository: injector.get()),
  );
  injector.registerLazySingleton<ConfirmAndSaveGeneratedAccountsUsecase>(
    () => ConfirmAndSaveGeneratedAccountsUsecase(
      accountsRepository: injector.get(),
    ),
  );
  injector.registerLazySingleton<ResetWalletUsecase>(
    () => ResetWalletUsecase(
      accountsRepository: injector.get(),
    ),
  );
  injector.registerLazySingleton<AccountDecryptionWithPasswordService>(
    () => AccountDecryptionWithPasswordServiceImpl(),
  );
  injector.registerLazySingleton<UnlockWalletUsecase>(
    () => UnlockWalletUsecase(
      accountsRepository: injector.get(),
      accountDecryptionWithPasswordService: injector.get(),
      passwordRepository: injector.get(),
    ),
  );
  injector.registerLazySingleton<NetworksDataSource>(
    () => NetworksDataSourceImpl(injector.get()),
  );
  injector.registerLazySingleton<NetworksRepository>(
    () => NetworksRepositoryImpl(injector.get(), injector.get()),
  );
  injector.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
  injector.registerLazySingleton<NativeBalanceDataSource>(
    () => NativeBalanceDataSourceImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<NativeBalanceRepository>(
    () => NativeBalanceRepositoryImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<GetNativeBalanceOfAccountUsecase>(
    () => GetNativeBalanceOfAccountUsecase(
      injector.get(),
      injector.get(),
      injector.get(),
    ),
  );
  injector.registerLazySingleton<MnemonicFactory>(
    () => MnemonicFactoryImpl(),
  );
  injector.registerLazySingleton<PasswordFactory>(
    () => PasswordFactoryImpl(),
  );
  injector.registerLazySingleton<EthereumAddressFactory>(
    () => EthereumAddressFactoryImpl(),
  );
  injector.registerLazySingleton<ContactsDataSource>(
    () => ContactsDataSourceImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<ContactsRepository>(
    () => ContactsRepositoryImpl(injector.get()),
  );
  injector.registerLazySingleton<ImportWalletUsecase>(
    () => ImportWalletUsecase(
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get()
    ),
  );
  injector.registerLazySingleton<AddContactUsecase>(
    () => AddContactUsecase(
      injector.get(),
      injector.get(),
    ),
  );
  injector.registerLazySingleton<EncryptionService>(
    () => EncryptionServiceImpl(),
  );

  injector.registerLazySingleton<MnemonicRepository>(
    () => MnemonicRepositoryImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<AddHdWalletAccountUsecase>(
    () => AddHdWalletAccountUsecase(
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
    ),
  );
}
