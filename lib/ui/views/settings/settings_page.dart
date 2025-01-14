import 'package:flutter/material.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/data/repositories/networks/network_repository.dart';
import 'package:kriptum/ui/views/settings/screens/general_screen.dart';
import 'package:kriptum/ui/views/settings/screens/networks/networks_screen.dart';
import 'package:kriptum/ui/views/settings/widgets/settings_submenu_card.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController settingsController;
  final NetworksController networksController;
  final CurrentNetworkController currentNetworkController;
  SettingsPage(
      {super.key,
      
      required this.settingsController,
      required this.networksController, required this.currentNetworkController});

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
          )
        ],
      ),
    );
  }
}
