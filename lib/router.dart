import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/ui/views/create_new_wallet_page.dart';
import 'package:kriptum/ui/views/import_wallet_page.dart';
import 'package:kriptum/ui/views/setup_page.dart';

class AppRoutes {
  static const setup = '/setup';
  static const createNewWallet = '/create-new-wallet';
  static const importWallet = '/import-wallet';
}

final routes = [
  GoRoute(
    path: AppRoutes.setup,
    builder: (context, state) => const SetupPage(),
  ),
  GoRoute(
    path: AppRoutes.createNewWallet,
    builder: (context, state) => const CreateNewWalletPage(),
  ),
  GoRoute(
    path: AppRoutes.importWallet,
    builder: (context, state) => const ImportWalletPage(),
  ),
];

final router = GoRouter(initialLocation: AppRoutes.setup, routes: routes);
