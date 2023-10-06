import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/app.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.maximize();

  runApp(const App());
}
