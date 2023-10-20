import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = true;

  runApp(const App());
}
