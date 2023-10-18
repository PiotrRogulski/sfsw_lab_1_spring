import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/hooks/use_reaction.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameter_store.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_store.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class ParametersForm extends LayoutSlot {
  const ParametersForm({super.key});

  @override
  String get title => 'Spring parameters';

  @override
  Widget build(BuildContext context) {
    final parameters = context.read<ParametersStore>();
    final simulation = context.read<SpringSimulationStore>();

    return SingleChildScrollView(
      child: Column(
        children: [
          _ParameterEntry(
            label: 'x₀',
            parameter: parameters.initialPosition,
          ),
          _ParameterEntry(
            label: 'v₀',
            parameter: parameters.initialVelocity,
          ),
          _ParameterEntry(
            label: 'Δt',
            parameter: parameters.timeDelta,
          ),
          _ParameterEntry(
            label: 'm',
            parameter: parameters.mass,
          ),
          _ParameterEntry(
            label: 'k',
            parameter: parameters.dampingConstant,
          ),
          _ParameterEntry(
            label: 'c',
            parameter: parameters.springConstant,
          ),
          Observer(
            builder: (context) {
              return switch (simulation.readings) {
                [..., final reading] => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${simulation.readings.length} Observed at ${reading.timestamp}',
                    ),
                  ),
                [] => const SizedBox(),
              };
            },
          ),
        ],
      ),
    );
  }
}

class _ParameterEntry extends HookWidget {
  const _ParameterEntry({
    required this.label,
    required this.parameter,
  });

  final String label;
  final ParameterStore parameter;

  @override
  Widget build(BuildContext context) {
    final ParameterStore(:precision, :bounds) = parameter;

    final controller = useTextEditingController(
      text: parameter.value.toStringAsFixed(precision),
    );

    useReaction(
      () => parameter.value,
      (value) => controller.text = value.toStringAsFixed(precision),
    );

    // ignore: avoid_types_on_closure_parameters
    final validator = useCallback((String? value) {
      if (value == null || double.tryParse(value) == null) {
        return '';
      }
      final parsed = double.parse(value);
      if (parsed < bounds.min || parsed > bounds.max) {
        return '';
      }
      return null;
    });

    return Observer(
      builder: (context) {
        final enabled = context.read<SpringSimulationStore>().status !=
            SimulationStatus.running;

        return Row(
          children: [
            const SizedBox(width: 8),
            SizedBox(
              width: 32,
              child: Text(
                label,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 64,
              child: TextFormField(
                enabled: enabled,
                controller: controller,
                onFieldSubmitted: (value) {
                  final parsed = double.tryParse(value);
                  if (parsed != null && validator(value) == null) {
                    parameter.value = parsed;
                  } else {
                    controller.text =
                        parameter.value.toStringAsFixed(precision);
                  }
                },
                autovalidateMode: AutovalidateMode.always,
                validator: validator,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Expanded(
              child: Slider(
                value: parameter.value,
                onChanged: enabled ? (value) => parameter.value = value : null,
                min: bounds.min,
                max: bounds.max,
                inactiveColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        );
      },
    );
  }
}
