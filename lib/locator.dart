import 'package:get_it/get_it.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/accounts/accounts_controller.dart';
import 'package:kriptum/controllers/contacts/contacts_controller.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/controllers/accounts/current_account_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/erase_wallet_controller.dart';
import 'package:kriptum/controllers/import_wallet_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/password_controller.dart';
import 'package:kriptum/controllers/send/send_amount_controller.dart';
import 'package:kriptum/controllers/send/send_transaction_controller.dart';
import 'package:kriptum/controllers/send/to_address_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/controllers/unlock_wallet_controller.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/repositories/account/account_repository_db_impl.dart';
import 'package:kriptum/data/repositories/contact/contacts_repository.dart';
import 'package:kriptum/data/repositories/contact/contacts_repository_memory_impl.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/data/repositories/networks/network_repository_db_implementation.dart';
import 'package:kriptum/data/services/encryption_service.dart';
import 'package:kriptum/data/services/settings_service.dart';
import 'package:kriptum/data/services/settings_service_impl.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/views/home_page/controllers/navigation_bar_controller.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  locator.registerCachedFactory(
    () => EncryptionService(),
  );
  locator.registerSingleton<NetworkRepository>(
      NetworkRepositoryDbImplementation());
  locator.registerSingleton<AccountRepository>(AccountRepositoryDbImpl());
  locator.registerSingleton<ContactsRepository>(ContactsRepositoryMemoryImpl());

  locator.registerLazySingleton<WalletServices>(() => WalletServices());
  locator.registerFactory<CreateWalletStepsController>(
    () => CreateWalletStepsController(),
  );
  locator.registerLazySingleton<CreateNewWalletController>(
    () => CreateNewWalletController(
      encryptionService: locator.get<EncryptionService>(),
      accountRepository: locator.get<AccountRepository>(),
      walletServices: locator.get<WalletServices>(),
    ),
  );

  locator.registerLazySingleton<AccountsController>(
    () => AccountsController(
        encryptionService: locator.get<EncryptionService>(),
        walletServices: locator.get<WalletServices>(),
        accountRepository: locator.get<AccountRepository>()),
  );
  locator.registerFactory<ContactsController>(
    () => ContactsController(
        contactsRepository: locator.get<ContactsRepository>()),
  );
  locator.registerLazySingleton<SettingsService>(() => SettingsServiceImpl());

  locator.registerLazySingleton<SettingsController>(
    () => SettingsController(settingsService: locator.get<SettingsService>()),
  );

  await locator.get<SettingsController>().initialize();

  locator.registerLazySingleton<NavigationBarController>(
      () => NavigationBarController());

  locator.registerFactory<ImportWalletController>(
    () => ImportWalletController(
        encryptionService: locator.get<EncryptionService>(),
        accountRepository: locator.get<AccountRepository>()),
  );

  locator.registerFactory<UnlockWalletController>(
    () => UnlockWalletController(
      accountsRepository: locator.get<AccountRepository>(),
      walletServices: locator.get<WalletServices>(),
    ),
  );

  locator.registerFactory<EraseWalletController>(
    () => EraseWalletController(
        accountRepository: locator.get<AccountRepository>()),
  );

  locator.registerLazySingleton<AccountBalanceController>(
    () =>
        AccountBalanceController(walletServices: locator.get<WalletServices>()),
  );
  locator.registerSingleton(
    CurrentNetworkController(
        networkRepository: locator.get<NetworkRepository>()),
  );
  locator.registerSingleton<NetworksController>(
    NetworksController(networkRepository: locator.get<NetworkRepository>()),
  );
  locator.registerSingleton<CurrentAccountController>(CurrentAccountController(
      accountRepository: locator.get<AccountRepository>()));
  locator.registerFactory<SendAmountController>(
    () => SendAmountController(),
  );
  locator.registerFactory<ToAddressController>(
    () => ToAddressController(),
  );
  locator.registerSingleton<PasswordController>(PasswordController());
  locator.registerFactory<SendTransactionController>(
    () => SendTransactionController(),
  );
}
