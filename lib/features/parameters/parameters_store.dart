import 'package:mobx/mobx.dart';

part 'parameters_store.g.dart';

class ParametersStore = _ParametersStoreBase with _$ParametersStore;

abstract class _ParametersStoreBase with Store {
  @observable
  double initialPosition = 0;

  @observable
  double initialVelocity = 0;

  @observable
  double timeDelta = 0.01;

  @observable
  double mass = 1;

  @observable
  double dampingConstant = 0.1;

  @observable
  double springConstant = 5;
}
