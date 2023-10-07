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
    bounds: const (min: 0, max: 20),
    initialValue: 5,
  );
}
