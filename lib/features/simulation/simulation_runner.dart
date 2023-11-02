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

  final oneOverMass = 1 / mass;
  double acceleration(double t) => totalForce(t) * oneOverMass;

  const secondsPerMicrosecond = 1 / Duration.microsecondsPerSecond;
  const millisecondsPerMicrosecond = 1 / Duration.microsecondsPerMillisecond;

  final beginningTime = DateTime.now();
  var lastTimestamp = beginningTime;
  Timer.periodic(Duration(milliseconds: timeDelta * 1000 ~/ 1), (_) {
    final now = DateTime.now();
    final timestamp = now.difference(beginningTime);
    final t = timestamp.inMicroseconds * millisecondsPerMicrosecond;
    final dt =
        now.difference(lastTimestamp).inMicroseconds * secondsPerMicrosecond;

    final currAcceleration = acceleration(t);

    final newY = y + Vector2(y[1], currAcceleration) * dt;

    port.send(
      Observation(
        timestamp: timestamp,
        position: newY[0],
        origin: originPosition(t),
        velocity: newY[1],
        acceleration: currAcceleration,
        springForce: springForce(t),
        dampingForce: dampingForce(t),
        externalForce: externalForce(t),
      ),
    );

    y = newY;
    lastTimestamp = now;
  });
}
