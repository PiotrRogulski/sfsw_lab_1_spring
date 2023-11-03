import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:sfsw_lab_1_spring/features/parameters/functional_parameter.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameter_store.dart';

part 'parameters_store.g.dart';

class ParametersStore = _ParametersStoreBase with _$ParametersStore;

abstract class _ParametersStoreBase with Store {
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
    bounds: const (min: 0.01, max: 30),
    initialValue: 1,
  );

  final dampingConstant = ParameterStore(
    bounds: const (min: 0.001, max: 3),
    initialValue: 0.1,
  );

  final springConstant = ParameterStore(
    bounds: const (min: 0.001, max: 50),
    initialValue: 5,
  );

  @observable
  FunctionalParameter externalForce = const ConstantParameter(0);

  @observable
  FunctionalParameter originPosition = const ConstantParameter(0);

  Parameters get values => Parameters(
        initialPosition: initialPosition.value,
        initialVelocity: initialVelocity.value,
        timeDelta: timeDelta.value,
        mass: mass.value,
        dampingConstant: dampingConstant.value,
        springConstant: springConstant.value,
        externalForce: externalForce,
        originPosition: originPosition,
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
