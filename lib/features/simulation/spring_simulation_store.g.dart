// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spring_simulation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SpringSimulationStore on _SpringSimulationStoreBase, Store {
  Computed<Observation?>? _$latestReadingComputed;

  @override
  Observation? get latestReading => (_$latestReadingComputed ??=
          Computed<Observation?>(() => super.latestReading,
              name: '_SpringSimulationStoreBase.latestReading'))
      .value;

  late final _$_statusAtom =
      Atom(name: '_SpringSimulationStoreBase._status', context: context);

  SimulationStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  SimulationStatus get _status => status;

  @override
  set _status(SimulationStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$startSimulationAsyncAction = AsyncAction(
      '_SpringSimulationStoreBase.startSimulation',
      context: context);

  @override
  Future<void> startSimulation() {
    return _$startSimulationAsyncAction.run(() => super.startSimulation());
  }

  late final _$stopSimulationAsyncAction = AsyncAction(
      '_SpringSimulationStoreBase.stopSimulation',
      context: context);

  @override
  Future<void> stopSimulation() {
    return _$stopSimulationAsyncAction.run(() => super.stopSimulation());
  }

  @override
  String toString() {
    return '''
latestReading: ${latestReading}
    ''';
  }
}
