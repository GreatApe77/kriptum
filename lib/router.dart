import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/accounts_controller.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/controllers/current_account_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/erase_wallet_controller.dart';
import 'package:kriptum/controllers/import_wallet_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/controllers/unlock_wallet_controller.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/locator.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/views/home_page/controllers/navigation_bar_controller.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/create_new_wallet_page.dart';
import 'package:kriptum/ui/views/home_page/home_page.dart';
import 'package:kriptum/ui/views/import_wallet/import_wallet_page.dart';
import 'package:kriptum/ui/views/receive/receive_page.dart';
import 'package:kriptum/ui/views/settings/settings_page.dart';
import 'package:kriptum/ui/views/setup_page.dart';
import 'package:kriptum/ui/views/unlock_wallet/unlock_wallet_page.dart';

class AppRoutes {
  static const setup = '/setup';
  static const createNewWallet = '/create-new-wallet';
  static const importWallet = '/import-wallet';
  static const home = '/home';
  static const unlockWallet = '/unlock-wallet';
  static const receive = '/receive';
  static const settings = '/settings';
}

final routes = [
  GoRoute(
    path: AppRoutes.unlockWallet,
    builder: (context, state) => UnlockWalletPage(
      eraseWalletController: locator.get<EraseWalletController>(),
      settingsController: locator.get<SettingsController>(),
      unlockWalletController: locator.get<UnlockWalletController>(),
    ),
  ),
  GoRoute(
    path: AppRoutes.setup,
    builder: (context, state) => const SetupPage(),
  ),
  GoRoute(
    path: AppRoutes.createNewWallet,
    builder: (context, state) => CreateNewWalletPage(
      settingsController: locator.get<SettingsController>(),
      createNewWalletController: locator.get<CreateNewWalletController>(),
      stepController: locator.get<CreateWalletStepsController>(),
    ),
  ),
  GoRoute(
    path: AppRoutes.importWallet,
    builder: (context, state) => ImportWalletPage(
      settingsController: locator.get<SettingsController>(),
      importWalletController: locator.get<ImportWalletController>(),
    ),
  ),
  GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => HomePage(
      currentAccountController: locator.get<CurrentAccountController>(),
      currentNetworkController: locator.get<CurrentNetworkController>(),
      networksController: locator.get<NetworksController>(),
      accountBalanceController: locator.get<AccountBalanceController>(),
      settingsController: locator.get<SettingsController>(),
      accountsController: locator.get<AccountsController>(),
      navigationBarController: locator.get<NavigationBarController>(),
    ),
  ),
  GoRoute(
    path: AppRoutes.receive,
    builder: (context, state) => ReceivePage(
      accountsController: locator.get<AccountsController>(),
    ),
  ),
  GoRoute(
    path: AppRoutes.settings,
    builder: (context, state) => SettingsPage(
      currentNetworkController: locator.get<CurrentNetworkController>(),
      networksController: locator.get<NetworksController>(),
      settingsController: locator.get<SettingsController>(),
    ),
  ),
];

final router = GoRouter(
    redirect: (context, state) {
      final settingsController = locator.get<SettingsController>();
      final isCreatingWallet = state.fullPath == AppRoutes.createNewWallet ||
          state.fullPath == AppRoutes.importWallet;
      final inSetupPage = state.fullPath == AppRoutes.setup;
      if (!settingsController.settings.containsWallet &&
          !isCreatingWallet &&
          !inSetupPage) {
        return AppRoutes.setup;
      }
      return null;
    },
    initialLocation: AppRoutes.unlockWallet,
    routes: routes);
