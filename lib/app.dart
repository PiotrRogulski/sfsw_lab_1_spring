import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:sfsw_lab_1_spring/common/widgets/breakpoint_selector.dart';
import 'package:sfsw_lab_1_spring/design_system/theme.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_large.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_medium.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_small.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // TODO: add a switch
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          elevation: 3,
        ),
        body: BreakpointSelector(
          builders: {
            Breakpoints.large: (context) => const LayoutLarge(
                  key: PageStorageKey('layout_large'),
                ),
            Breakpoints.medium: (context) => const LayoutMedium(
                  key: PageStorageKey('layout_medium'),
                ),
            Breakpoints.small: (context) => const LayoutSmall(
                  key: PageStorageKey('layout_small'),
                ),
          },
        ),
      ),
    );
  }
}
