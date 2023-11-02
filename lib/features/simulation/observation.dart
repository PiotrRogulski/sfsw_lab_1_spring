import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Observation with EquatableMixin {
  const Observation({
    required this.timestamp,
    required this.position,
    required this.origin,
    required this.velocity,
    required this.acceleration,
    required this.springForce,
    required this.dampingForce,
    required this.externalForce,
  });

  final Duration timestamp;
  final double position;
  final double origin;
  final double velocity;
  final double acceleration;
  final double springForce;
  final double dampingForce;
  final double externalForce;

  @override
  List<Object?> get props => [
        timestamp,
        position,
        origin,
        velocity,
        acceleration,
        springForce,
        dampingForce,
        externalForce,
      ];
}
