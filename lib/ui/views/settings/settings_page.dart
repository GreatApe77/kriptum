import 'package:flutter/material.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/ui/views/settings/screens/general_screen.dart';
import 'package:kriptum/ui/views/settings/screens/networks_screen.dart';
import 'package:kriptum/ui/views/settings/widgets/settings_submenu_card.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController settingsController;
  final NetworkRepository networkRepository;
  SettingsPage({super.key, required this.settingsController, required this.networkRepository});

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
            description: 'General settings like theme...',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  GeneralScreen(settingsController: settingsController),
            )),
          ),
          SettingsSubmenuCard(
            title: 'Networks',
            description: 'Manage your connected networks',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  NetworksScreen(networkRepository:networkRepository ),
            )),
          )
        ],
      ),
    );
  }
}
