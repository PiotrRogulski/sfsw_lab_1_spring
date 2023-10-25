import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_store.dart';
import 'package:sfsw_lab_1_spring/features/simulation/observation.dart';
import 'package:vector_math/vector_math.dart';

part 'simulation_runner.dart';
part 'spring_simulation_store.g.dart';

class SpringSimulationStore = _SpringSimulationStoreBase
    with _$SpringSimulationStore;

enum SimulationStatus { idle, starting, running, paused }

abstract class _SpringSimulationStoreBase with Store {
  _SpringSimulationStoreBase({
    required this.parametersStore,
  });

  final ParametersStore parametersStore;

  final readings = ObservableList<Observation>();

  final positionPoints = ObservableList<FlSpot>();
  final velocityPoints = ObservableList<FlSpot>();
  final accelerationPoints = ObservableList<FlSpot>();
  final trajectoryPoints = ObservableList<FlSpot>();
  final springForcePoints = ObservableList<FlSpot>();
  final dampingForcePoints = ObservableList<FlSpot>();
  final externalForcePoints = ObservableList<FlSpot>();

  @computed
  Observation? get latestReading => readings.lastOrNull;

  @readonly
  var _status = SimulationStatus.idle;

  @readonly
  var _trajectoryBounds = (maxX: 0.0, maxY: 0.0);

  @readonly
  var _positionBounds = 0.0;

  @readonly
  var _forcesBounds = 0.0;

  Isolate? _isolateInstance;
  StreamSubscription<Observation>? _isolateToMainStreamSub;

  void _reset() {
    for (final list in [
      readings,
      positionPoints,
      velocityPoints,
      accelerationPoints,
      trajectoryPoints,
      springForcePoints,
      dampingForcePoints,
      externalForcePoints,
    ]) {
      list.clear();
    }
    _trajectoryBounds = (maxX: 0, maxY: 0);
    _positionBounds = 0;
    _forcesBounds = 0;
  }

  @action
  Future<void> startSimulation() async {
    _status = SimulationStatus.starting;
    _reset();
    final isolateToMainPort = ReceivePort();

    _isolateToMainStreamSub = isolateToMainPort.whereType<Observation>().listen(
      (data) {
        readings.add(data);

        final t =
            data.timestamp.inMicroseconds / Duration.microsecondsPerSecond;

        positionPoints.add(FlSpot(t, data.position));
        velocityPoints.add(FlSpot(t, data.velocity));
        accelerationPoints.add(FlSpot(t, data.acceleration));
        trajectoryPoints.add(FlSpot(data.position, data.velocity));
        springForcePoints.add(FlSpot(t, data.springForce));
        dampingForcePoints.add(FlSpot(t, data.dampingForce));
        externalForcePoints.add(FlSpot(t, data.externalForce));

        _trajectoryBounds = (
          maxX: max(data.position.abs(), _trajectoryBounds.maxX),
          maxY: max(data.velocity.abs(), _trajectoryBounds.maxY),
        );
        _positionBounds = [
          _positionBounds,
          data.position.abs(),
          data.velocity.abs(),
          data.acceleration.abs(),
        ].max;
        _forcesBounds = [
          _forcesBounds,
          data.springForce.abs(),
          data.dampingForce.abs(),
          data.externalForce.abs(),
        ].max;
      },
    );

    _isolateInstance = await Isolate.spawn(
      _runSimulation,
      (isolateToMainPort.sendPort, parametersStore.values),
      debugName: 'Simulation',
    );

    _status = SimulationStatus.running;
  }

  @action
  Future<void> stopSimulation() async {
    await _isolateToMainStreamSub?.cancel();
    _isolateToMainStreamSub = null;
    _isolateInstance?.kill();
    _isolateInstance = null;
    _status = SimulationStatus.idle;
  }
}
