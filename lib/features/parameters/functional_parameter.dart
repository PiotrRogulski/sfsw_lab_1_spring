import 'dart:math' as math;

import 'package:equatable/equatable.dart';

String _fmt(double value) => value.toString();

typedef ParameterSetupData<T extends FunctionalParameter> = ({
  String formula,
  List<String> variables,
  T Function(Map<String, double> vars) builder,
});

sealed class FunctionalParameter with EquatableMixin {
  const FunctionalParameter();

  double call(double t);

  String get formula => 'f(t) = $_formula';
  String get _formula;
  Map<String, double> get variableValues;
}

class ConstantParameter extends FunctionalParameter {
  const ConstantParameter(this.value);

  ConstantParameter.fromMap(Map<String, double> params) : this(params['A']!);

  final double value;

  @override
  double call(double t) => value;

  @override
  String get _formula => _fmt(value);

  @override
  Map<String, double> get variableValues => {'A': value};

  static ParameterSetupData<ConstantParameter> get setupData => (
        formula: 'f(t) = A',
        variables: const ['A'],
        builder: ConstantParameter.fromMap,
      );

  @override
  List<Object?> get props => [value];
}

class SinusoidalParameter extends FunctionalParameter {
  const SinusoidalParameter({
    required this.amplitude,
    required this.frequency,
    required this.phase,
  });

  SinusoidalParameter.fromMap(Map<String, double> params)
      : this(
          amplitude: params['A']!,
          frequency: params['ω']!,
          phase: params['φ']!,
        );

  final double amplitude;
  final double frequency;
  final double phase;

  @override
  double call(double t) => amplitude * math.sin(frequency * t + phase);

  @override
  String get _formula =>
      '${_fmt(amplitude)} * sin(${_fmt(frequency)} * t + ${_fmt(phase)})';

  @override
  Map<String, double> get variableValues =>
      {'A': amplitude, 'ω': frequency, 'φ': phase};

  static ParameterSetupData<SinusoidalParameter> get setupData => (
        formula: 'f(t) = A * sin(ω * t + φ)',
        variables: const ['A', 'ω', 'φ'],
        builder: SinusoidalParameter.fromMap,
      );

  @override
  List<Object?> get props => [amplitude, frequency, phase];
}

class SquareWaveParameter extends FunctionalParameter {
  const SquareWaveParameter({
    required this.amplitude,
    required this.frequency,
    required this.phase,
  });

  SquareWaveParameter.fromMap(Map<String, double> params)
      : this(
          amplitude: params['A']!,
          frequency: params['ω']!,
          phase: params['φ']!,
        );

  final double amplitude;
  final double frequency;
  final double phase;

  @override
  double call(double t) => amplitude * math.sin(frequency * t + phase).sign;

  @override
  String get _formula =>
      '${_fmt(amplitude)} * sgn(sin(${_fmt(frequency)} * t + ${_fmt(phase)}))';

  @override
  Map<String, double> get variableValues =>
      {'A': amplitude, 'ω': frequency, 'φ': phase};

  static ParameterSetupData<SquareWaveParameter> get setupData => (
        formula: 'f(t) = A * sgn(sin(ω * t + φ))',
        variables: const ['A', 'ω', 'φ'],
        builder: SquareWaveParameter.fromMap,
      );

  @override
  List<Object?> get props => [amplitude, frequency, phase];
}
