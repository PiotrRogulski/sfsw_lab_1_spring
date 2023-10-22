import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/design_system/theme.dart';
import 'package:sfsw_lab_1_spring/features/settings/settings_store.dart';
import 'package:sfsw_lab_1_spring/home.dart';
import 'package:sfsw_lab_1_spring/providers.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AppProviders(
      child: _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsStore>();

    return DynamicColorBuilder(
      builder: (lightScheme, darkScheme) {
        return Observer(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(lightScheme),
              darkTheme: AppTheme.dark(darkScheme),
              themeMode: settings.themeMode,
              home: const Home(),
            );
          },
        );
      },
    );
  }
}
