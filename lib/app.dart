import 'package:flutter/material.dart';
import 'package:kriptum/router.dart';
import 'package:kriptum/ui/views/setup_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
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
}