import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/widgets/breakpoint_selector.dart';
import 'package:sfsw_lab_1_spring/design_system/theme.dart';
import 'package:sfsw_lab_1_spring/features/settings/settings_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_large.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_medium.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_small.dart';
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
      home: Scaffold(
        appBar: AppBar(
          elevation: 3,
          actions: [
            IconButton(
              onPressed: () {
                settings.themeMode = settings.themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
              icon: Icon(
                settings.themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
          ],
        ),
        body: BreakpointSelector(
          builders: {
            AppBreakpoint.large: (context) => const LayoutLarge(
                  key: PageStorageKey('layout_large'),
                ),
            AppBreakpoint.medium: (context) => const LayoutMedium(
                  key: PageStorageKey('layout_medium'),
                ),
            AppBreakpoint.small: (context) => const LayoutSmall(
                  key: PageStorageKey('layout_small'),
                ),
          },
        ),
      ),
    );
  }
}

enum AppBreakpoint implements Breakpoint {
  small(end: 700),
  medium(begin: 700, end: 1200),
  large(begin: 1200);

  const AppBreakpoint({
    this.begin = double.negativeInfinity,
    this.end = double.infinity,
  });

  final double begin;
  final double end;

  @override
  bool isActive(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return width >= begin && width < end;
  }
}
