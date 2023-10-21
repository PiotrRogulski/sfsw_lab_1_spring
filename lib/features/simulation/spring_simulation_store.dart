import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_store.dart';
import 'package:sfsw_lab_1_spring/features/simulation/observation.dart';
import 'package:vector_math/vector_math.dart';

part 'simulation_runner.dart';
part 'spring_simulation_store.g.dart';

class SpringSimulationStore = _SpringSimulationStoreBase
    with _$SpringSimulationStore;

abstract class _SpringSimulationStoreBase with Store {
  _SpringSimulationStoreBase({
    required this.parametersStore,
  });

  final ParametersStore parametersStore;

  final readings = ObservableList<Observation>();

  @computed
  Observation? get latestReading => readings.lastOrNull;

  @readonly
  var _status = SimulationStatus.idle;

  @readonly
  var _trajectoryBounds = (maxX: 0.0, maxY: 0.0);

  @readonly
  var _positionBounds = 0.0;

  Isolate? _isolateInstance;
  StreamSubscription<Observation>? _isolateToMainStreamSub;

  void _reset() {
    readings.clear();
    _trajectoryBounds = (maxX: 0, maxY: 0);
    _positionBounds = 0;
  }

  @action
  Future<void> startSimulation() async {
    _status = SimulationStatus.starting;
    _reset();
    final isolateToMainPort = ReceivePort();

    _isolateToMainStreamSub = isolateToMainPort.whereType<Observation>().listen(
      (data) {
        readings.add(data);
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

enum SimulationStatus { idle, starting, running, paused }
