import 'package:meta/meta.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameter_store.dart';

class ParametersStore {
  final initialPosition = ParameterStore(
    bounds: const (min: -10, max: 10),
    initialValue: 0,
  );

  final initialVelocity = ParameterStore(
    bounds: const (min: -10, max: 10),
    initialValue: 0,
  );

  final timeDelta = ParameterStore(
    bounds: const (min: 0.001, max: 0.1),
    initialValue: 0.01,
    precision: 3,
  );

  final mass = ParameterStore(
    bounds: const (min: 0.1, max: 20),
    initialValue: 1,
  );

  final dampingConstant = ParameterStore(
    bounds: const (min: 0, max: 1),
    initialValue: 0.1,
  );

  final springConstant = ParameterStore(
    bounds: const (min: 0, max: 50),
    initialValue: 5,
  );

  Parameters get values => Parameters(
        initialPosition: initialPosition.value,
        initialVelocity: initialVelocity.value,
        timeDelta: timeDelta.value,
        mass: mass.value,
        dampingConstant: dampingConstant.value,
        springConstant: springConstant.value,
        // TODO: allow external force to be set
        externalForce: (t) => 0,
        // TODO: allow origin position to be set
        originPosition: (t) => 0,
      );
}

@immutable
class Parameters {
  const Parameters({
    required this.initialPosition,
    required this.initialVelocity,
    required this.timeDelta,
    required this.mass,
    required this.dampingConstant,
    required this.springConstant,
    required this.externalForce,
    required this.originPosition,
  });

  final double initialPosition;
  final double initialVelocity;
  final double timeDelta;
  final double mass;
  final double dampingConstant;
  final double springConstant;
  final double Function(double) externalForce;
  final double Function(double) originPosition;
}
