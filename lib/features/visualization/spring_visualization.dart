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

    final minValue = useState(2 * min);
    final maxValue = useState(2 * max);

    useEffect(
      () {
        final position = currentReading?.position;
        if (position == null) {
          minValue.value = 2 * min;
          maxValue.value = 2 * max;
          return null;
        }

        if (position < minValue.value) {
          minValue.value = position;
        }
        if (position > maxValue.value) {
          maxValue.value = position;
        }

        return null;
      },
      [currentReading?.position],
    );

    return Placeholder(
      color: Colors.transparent,
      child: Center(
        child: switch (currentReading) {
          null => const Text('Spring visualization'),
          Observation(:final position, :final origin) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 64,
                      child: Text(
                        'Origin',
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        min: minValue.value,
                        max: maxValue.value,
                        value: origin,
                        onChanged: null,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 64,
                      child: Text(
                        'Position',
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        min: minValue.value,
                        max: maxValue.value,
                        value: position,
                        onChanged: null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
        },
      ),
    );
  }
}
