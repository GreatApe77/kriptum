import 'package:flutter/material.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/locator.dart';
import 'package:kriptum/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: locator.get<SettingsController>(),
      builder: (context,child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: locator.get<SettingsController>().settings.isDarkTheme?ThemeMode.dark:ThemeMode.light,
          darkTheme: ThemeData(
            colorScheme:ColorScheme.fromSeed(seedColor: Colors.greenAccent,brightness: Brightness.dark)
          ),
          theme: ThemeData(
            
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent)
          ),
          title: 'Kriptum',
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
        
        );
      }
    );
  }
}