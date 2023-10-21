import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/hooks/use_observable.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_store.dart';
import 'package:sfsw_lab_1_spring/features/simulation/observation.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class SpringVisualization extends HookWidget with LayoutSlot {
  const SpringVisualization({super.key});

  @override
  String get title => 'Spring visualization';

  @override
  Widget build(BuildContext context) {
    final simulationStore = context.read<SpringSimulationStore>();
    final parametersStore = context.read<ParametersStore>();

    final currentReading = useObservable(() => simulationStore.latestReading);

    final (:min, :max) = parametersStore.initialPosition.bounds;

    return Placeholder(
      color: Colors.transparent,
      child: Center(
        child: switch (currentReading) {
          null => const Text('Spring visualization'),
          // TODO: nicer spring visualization
          Observation(:final position) => Slider(
              min: 2 * min,
              max: 2 * max,
              value: position,
              onChanged: null,
            ),
        },
      ),
    );
  }
}
