import 'package:mobx/mobx.dart';

part 'parameter_store.g.dart';

class ParameterStore = _ParameterStoreBase with _$ParameterStore;

abstract class _ParameterStoreBase with Store {
  _ParameterStoreBase({
    required this.bounds,
    required double initialValue,
    // ignore: unused_element
    this.precision = 2,
  }) : value = initialValue;

  final ({double min, double max}) bounds;

  @observable
  double value;

  final int precision;
}
