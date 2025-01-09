//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kriptum/app.dart';
import 'package:kriptum/locator.dart';

//import 'httpfix/my_http_overrides.dart';
///Application entrypoint
void main(List<String> args)async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const App());
}