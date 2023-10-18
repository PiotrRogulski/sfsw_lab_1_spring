import 'dart:async';
import 'dart:isolate';

import 'package:mobx/mobx.dart';
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

  Isolate? _isolateInstance;
  StreamSubscription<dynamic>? _isolateToMainStreamSub;

  @action
  Future<void> startSimulation() async {
    _status = SimulationStatus.starting;
    final isolateToMainPort = ReceivePort();

    _isolateToMainStreamSub = isolateToMainPort.listen((data) {
      print('Received $data');
      if (data is Observation) {
        readings.add(data);
      }
    });

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
