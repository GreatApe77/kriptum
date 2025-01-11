import 'package:flutter/material.dart';
import 'package:kriptum/controllers/settings_controller.dart';

class GeneralScreen extends StatelessWidget {
  final SettingsController settingsController;
  const GeneralScreen({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General'),
      ),
      body: ListView(
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
      ),
    );
  }
}