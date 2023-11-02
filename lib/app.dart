import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _App extends StatelessObserverWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsStore>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      home: const Home(),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyQ, control: true):
            VoidCallbackIntent(SystemNavigator.pop),
      },
    );
  }
}
