import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/password_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/views/settings/screens/general_screen.dart';
import 'package:kriptum/ui/views/settings/screens/networks/networks_screen.dart';
import 'package:kriptum/ui/views/settings/widgets/settings_submenu_card.dart';

class SettingsPage extends StatelessWidget {
  final PasswordController passwordController;
  final SettingsController settingsController;
  final NetworksController networksController;
  final CurrentNetworkController currentNetworkController;
  const SettingsPage(
      {super.key,
      required this.settingsController,
      required this.networksController,
      required this.currentNetworkController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          SettingsSubmenuCard(
            title: 'General',
            description: 'General settings like theming...',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  GeneralScreen(settingsController: settingsController),
            )),
          ),
          SettingsSubmenuCard(
            title: 'Networks',
            description: 'Add and edit custom RPC networks',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NetworksScreen(
                currentNetworkController: currentNetworkController,
                networksController: networksController,
                settingsController: settingsController,
              ),
            )),
          ),
          ListTile(
            title:  Text('Lock Wallet',style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary
            ),),
            onTap: () => _triggerLockWallet(context),
          )
        ],
      ),
    );
  }

  void _triggerLockWallet(BuildContext context) async {
    passwordController.clearPassword();
    await settingsController.setIsLockedWallet(true);
    if (!context.mounted) return;
    GoRouter.of(context).go(AppRoutes.unlockWallet);
  }
}
