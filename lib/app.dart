import 'package:flutter/material.dart';
import 'package:kriptum/ui/views/setup_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kriptum',
      home: SetupPage(),
    );
  }
}