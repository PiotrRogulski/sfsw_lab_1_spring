import 'dart:math' as math;

import 'package:equatable/equatable.dart';

sealed class FunctionalParameter with EquatableMixin {
  const FunctionalParameter();

  double call(double t);

  String get formula => 'f(t) = $_formula';
  String get _formula;
}

class ConstantParameter extends FunctionalParameter {
  const ConstantParameter(this.value);

  final double value;

  @override
  double call(double t) => value;

  @override
  String get _formula => value.toStringAsFixed(2);

  @override
  List<Object?> get props => [value];
}

class SinusoidalParameter extends FunctionalParameter {
  const SinusoidalParameter({
    required this.amplitude,
    required this.frequency,
    required this.phase,
  });

  final double amplitude;
  final double frequency;
  final double phase;

  @override
  double call(double t) => amplitude * math.sin(frequency * t + phase);

  @override
  String get _formula =>
      '${amplitude.toStringAsFixed(2)} * sin(${frequency.toStringAsFixed(2)} * t + ${phase.toStringAsFixed(2)})';

  @override
  List<Object?> get props => [amplitude, frequency, phase];
}

class SquareWaveParameter extends FunctionalParameter {
  const SquareWaveParameter({
    required this.amplitude,
    required this.frequency,
    required this.phase,
  });

  final double amplitude;
  final double frequency;
  final double phase;

  @override
  double call(double t) => amplitude * math.sin(frequency * t + phase).sign;

  @override
  String get _formula =>
      '${amplitude.toStringAsFixed(2)} * sgn(sin(${frequency.toStringAsFixed(2)} * t + ${phase.toStringAsFixed(2)}))';

  @override
  List<Object?> get props => [amplitude, frequency, phase];
}
