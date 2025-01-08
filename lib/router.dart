import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/accounts_controller.dart.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/controllers/import_wallet_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/locator.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/views/home_page/controllers/navigation_bar_controller.dart';
import 'package:kriptum/ui/views/create_new_wallet_page/create_new_wallet_page.dart';
import 'package:kriptum/ui/views/home_page/home_page.dart';
import 'package:kriptum/ui/views/import_wallet/import_wallet_page.dart';
import 'package:kriptum/ui/views/setup_page.dart';

class AppRoutes {
  static const setup = '/setup';
  static const createNewWallet = '/create-new-wallet';
  static const importWallet = '/import-wallet';
  static const home = '/home';
}

final routes = [
  GoRoute(
    path: AppRoutes.setup,
    builder: (context, state) => const SetupPage(),
  ),
  GoRoute(
    path: AppRoutes.createNewWallet,
    builder: (context, state) => CreateNewWalletPage(
      createNewWalletController: locator.get<CreateNewWalletController>(),
      stepController: locator.get<CreateWalletStepsController>(),
    ),
  ),
  GoRoute(
    path: AppRoutes.importWallet,
    builder: (context, state) =>  ImportWalletPage(
      importWalletController: locator.get<ImportWalletController>(),
    ),
  ),
  GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => HomePage(
      settingsController: locator.get<SettingsController>(),
      connectedAccountController: locator.get<AccountsController>(),
      navigationBarController: locator.get<NavigationBarController>(),
    ),
  ),
];

final router = GoRouter(initialLocation: AppRoutes.setup, routes: routes);
