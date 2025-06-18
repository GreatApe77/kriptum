import 'package:flutter/material.dart';
import 'package:kriptum/ui/pages/general_settings/general_settings_page.dart';
import 'package:kriptum/ui/pages/networks/networks_page.dart';
import 'package:kriptum/ui/pages/settings/widgets/settings_submenu_card.dart';

class SettingsPage extends StatelessWidget {
  static final settingsPageNavigatorKey = GlobalKey<NavigatorState>();
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: settingsPageNavigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => const _SettingsView(),
        );
      },
    );
    /*  return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SettingsSubmenuCard(
            title: 'General',
            description: 'General settings like theming...',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GeneralSettingsPage(),
              ),
            ),
          ),
        ],
      ),
    ); */
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SettingsSubmenuCard(
            title: 'General',
            description: 'General settings like theming...',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GeneralSettingsPage(),
              ),
            ),
          ),
          SettingsSubmenuCard(
            title: 'Networks',
            description: 'Add and edit custom RPC networks',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NetworksPage(),
              ),
            ),
          ),
          SettingsSubmenuCard(
            title: 'Contacts',
            description: 'Add, edit, remove and manage your contacts',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GeneralSettingsPage(),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Lock Wallet',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            //onTap: () => _triggerLockWallet(context),
          )
        ],
      ),
    );
  }
}
