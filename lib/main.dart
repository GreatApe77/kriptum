import 'package:flutter/material.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';
import 'package:kriptum/ui/app.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await initInjector();
  await injector.get<SqlDatabase>().initialize();
  runApp(const App());
}
