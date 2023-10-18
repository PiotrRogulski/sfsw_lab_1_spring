import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/features/simulation/observation.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class SpringVisualization extends LayoutSlot {
  const SpringVisualization({super.key});

  @override
  String get title => 'Spring visualization';

  @override
  Widget build(BuildContext context) {
    final simulationStore = context.read<SpringSimulationStore>();

    return Observer(
      builder: (context) {
        final currentReading = simulationStore.latestReading;

        return Placeholder(
          color: Colors.transparent,
          child: Center(
            child: switch (currentReading) {
              null => const Text('Spring visualization'),
              // TODO: nicer spring visualization
              Observation(:final position) => Slider(
                  min: -10,
                  max: 10,
                  value: position,
                  onChanged: null,
                ),
            },
          ),
        );
      },
    );
  }
}
