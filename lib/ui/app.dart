import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/theme/theme_bloc.dart';
import 'package:kriptum/ui/pages/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  static final navigator = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
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
          themeMode: state is ThemeDark ? ThemeMode.dark : ThemeMode.light,
          title: 'Kriptum',
          navigatorKey: navigator,
          home: SplashPage(),
        );
      },
    );
  }
}
