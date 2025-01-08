import 'package:flutter/material.dart';
import 'package:kriptum/controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController settingsController;
   SettingsScreen({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        ListTile(
          title: Text('Dark Theme'),
          trailing: ListenableBuilder(
            listenable: settingsController,
            builder: (context,child) {
              return Switch(
                value: settingsController.settings.isDarkTheme,
                onChanged: (value) => settingsController.toggleTheme(),
              );
            }
          ),
        )
      ],
    ));
  }
}
