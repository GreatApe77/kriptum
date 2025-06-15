import 'package:flutter/material.dart';
import 'package:kriptum/ui/pages/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  static final navigator = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
          brightness: Brightness.dark,
        ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
        ),
      ),
      title: 'Kriptum',
      navigatorKey: navigator,
      home: SplashPage(),
    );
  }
}
