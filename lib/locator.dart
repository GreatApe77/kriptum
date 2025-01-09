import 'package:get_it/get_it.dart';
import 'package:kriptum/controllers/accounts_controller.dart.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/controllers/erase_wallet_controller.dart';
import 'package:kriptum/controllers/import_wallet_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/controllers/unlock_wallet_controller.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/data/repositories/account/account_repository__memory_impl.dart';
import 'package:kriptum/data/repositories/account/account_repository_db_impl.dart';
import 'package:kriptum/data/services/settings_service.dart';
import 'package:kriptum/data/services/settings_service_impl.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/views/home_page/controllers/navigation_bar_controller.dart';

final locator = GetIt.instance;
Future<void> setup() async {
  locator.registerSingleton<AccountRepository>(AccountRepositoryDbImpl());
  locator.registerFactory(() => CreateWalletStepsController());
  locator.registerCachedFactory(
    () => NavigationBarController(),
  );
  locator.registerCachedFactory<WalletServices>(() => WalletServices());
  locator.registerSingleton<CreateNewWalletController>(
      CreateNewWalletController(
          accountRepository: locator.get<AccountRepository>(),
          walletServices: locator.get<WalletServices>()));
  locator.registerSingleton<AccountsController>(
      AccountsController(accountRepository: locator.get<AccountRepository>()));
  locator.registerLazySingleton<SettingsService>(
    () => SettingsServiceImpl(),
  );
  locator.registerSingleton<SettingsController>(
      SettingsController(settingsService: locator.get<SettingsService>()));
  await locator.get<SettingsController>().initialize();
  //await locator.get<SettingsController>().setContainsWallet(false);
  locator.registerFactory<ImportWalletController>(
    () => ImportWalletController(),
  );
  locator.registerFactory(
    () => UnlockWalletController(
        accountsRepository: locator.get<AccountRepository>(),
        walletServices: locator.get<WalletServices>()),
  );
  locator.registerFactory<EraseWalletController>(
    () => EraseWalletController(
        accountRepository: locator.get<AccountRepository>()),
  );
}
