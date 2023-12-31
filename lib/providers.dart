import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_store.dart';
import 'package:sfsw_lab_1_spring/features/settings/settings_store.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => SettingsStore(
            themeMode: PlatformDispatcher.instance.platformBrightness ==
                    Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
          ),
        ),
        Provider(
          create: (context) => ParametersStore(),
        ),
        Provider(
          create: (context) => SpringSimulationStore(
            parametersStore: context.read(),
          ),
        ),
      ],
      child: child,
    );
  }
}
