part of 'spring_simulation_store.dart';

@pragma('vm:entry-point')
Future<void> _runSimulation((SendPort, Parameters) args) async {
  final (
    port,
    Parameters(
      :initialPosition,
      :initialVelocity,
      :timeDelta,
      :mass,
      :dampingConstant,
      :springConstant,
      :externalForce,
      :originPosition,
    ),
  ) = args;

  var y = Vector2(initialPosition, initialVelocity);

  double springForce(double t) => springConstant * (originPosition(t) - y[0]);
  double dampingForce(double t) => -dampingConstant * y[1];
  double totalForce(double t) =>
      springForce(t) + dampingForce(t) + externalForce(t);
  double acceleration(double t) => totalForce(t) / mass;

  final beginningTime = DateTime.now();
  Timer.periodic(Duration(milliseconds: timeDelta * 1000 ~/ 1), (_) {
    final timestamp = DateTime.now().difference(beginningTime);
    final t = timestamp.inMicroseconds / Duration.microsecondsPerMillisecond;

    final currAcceleration = acceleration(t);

    final newY = y + Vector2(y[1], currAcceleration) * timeDelta;

    port.send(
      Observation(
        timestamp: timestamp,
        position: newY[0],
        velocity: newY[1],
        acceleration: currAcceleration,
        springForce: springForce(t),
        dampingForce: dampingForce(t),
        externalForce: externalForce(t),
      ),
    );

    y = newY;
  });
}
