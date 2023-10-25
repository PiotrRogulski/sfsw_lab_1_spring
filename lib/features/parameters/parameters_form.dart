import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/hooks/use_observable.dart';
import 'package:sfsw_lab_1_spring/common/hooks/use_reaction.dart';
import 'package:sfsw_lab_1_spring/common/widgets/conditional_wrapper.dart';
import 'package:sfsw_lab_1_spring/features/parameters/functional_parameter_button.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameter_store.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_store.dart';
import 'package:sfsw_lab_1_spring/features/simulation/observation.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

part 'latest_reading.dart';
part 'parameter_entry.dart';

class ParametersForm extends HookWidget with LayoutSlot {
  const ParametersForm({super.key});

  @override
  String get title => 'Spring parameters';

  @override
  Widget build(BuildContext context) {
    final parameters = context.read<ParametersStore>();
    final simulation = context.read<SpringSimulationStore>();

    final reading = useObservable(() => simulation.latestReading);

    final externalForce = useObservable(() => parameters.externalForce);
    final originPosition = useObservable(() => parameters.originPosition);

    final parentScrollable = Scrollable.maybeOf(context);

    return ConditionalWrapper(
      enabled: parentScrollable == null,
      wrapper: (child) => SingleChildScrollView(
        child: child,
      ),
      child: Column(
        children: [
          _ParameterEntry(
            label: 'x₀',
            description: 'Initial position',
            parameter: parameters.initialPosition,
          ),
          _ParameterEntry(
            label: 'v₀',
            description: 'Initial velocity',
            parameter: parameters.initialVelocity,
          ),
          _ParameterEntry(
            label: 'Δt',
            description: 'Simulation time delta',
            parameter: parameters.timeDelta,
          ),
          _ParameterEntry(
            label: 'm',
            description: 'Mass',
            parameter: parameters.mass,
          ),
          _ParameterEntry(
            label: 'k',
            description: 'Damping constant',
            parameter: parameters.dampingConstant,
          ),
          _ParameterEntry(
            label: 'c',
            description: 'Spring constant',
            parameter: parameters.springConstant,
          ),
          FunctionalParameterButton(
            label: 'External force',
            parameterValue: externalForce,
            parameterSetter: (value) => parameters.externalForce = value,
          ),
          FunctionalParameterButton(
            label: 'Origin position',
            parameterValue: originPosition,
            parameterSetter: (value) => parameters.originPosition = value,
          ),
          if (reading != null)
            _LatestReading(
              reading: reading,
            ),
        ],
      ),
    );
  }
}
