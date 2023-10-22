import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/extensions/brightness.dart';
import 'package:sfsw_lab_1_spring/common/widgets/breakpoint_selector.dart';
import 'package:sfsw_lab_1_spring/features/settings/settings_store.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_large.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_medium.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_small.dart';

class Home extends StatelessObserverWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsStore>();
    final simulation = context.read<SpringSimulationStore>();

    final brightness = Theme.of(context).brightness;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        statusBarBrightness: brightness,
        statusBarIconBrightness: brightness.opposite,
        systemNavigationBarIconBrightness: brightness.opposite,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: Row(
            children: [
              IconButton.filledTonal(
                onPressed: simulation.status == SimulationStatus.running
                    ? null
                    : simulation.startSimulation,
                icon: const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: simulation.status == SimulationStatus.running
                    ? simulation.stopSimulation
                    : null,
                icon: const Icon(Icons.stop),
              ),
            ],
          ),
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
