import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/theme/theme_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';
import 'package:kriptum/ui/app.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await initInjector();
  await injector.get<SqlDatabase>().initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: const App(),
    ),
  );
}
