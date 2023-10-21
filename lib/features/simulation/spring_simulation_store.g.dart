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

  late final _$_trajectoryBoundsAtom = Atom(
      name: '_SpringSimulationStoreBase._trajectoryBounds', context: context);

  ({double maxX, double maxY}) get trajectoryBounds {
    _$_trajectoryBoundsAtom.reportRead();
    return super._trajectoryBounds;
  }

  @override
  ({double maxX, double maxY}) get _trajectoryBounds => trajectoryBounds;

  @override
  set _trajectoryBounds(({double maxX, double maxY}) value) {
    _$_trajectoryBoundsAtom.reportWrite(value, super._trajectoryBounds, () {
      super._trajectoryBounds = value;
    });
  }

  late final _$_positionBoundsAtom = Atom(
      name: '_SpringSimulationStoreBase._positionBounds', context: context);

  double get positionBounds {
    _$_positionBoundsAtom.reportRead();
    return super._positionBounds;
  }

  @override
  double get _positionBounds => positionBounds;

  @override
  set _positionBounds(double value) {
    _$_positionBoundsAtom.reportWrite(value, super._positionBounds, () {
      super._positionBounds = value;
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
