// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameters_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ParametersStore on _ParametersStoreBase, Store {
  late final _$initialPositionAtom =
      Atom(name: '_ParametersStoreBase.initialPosition', context: context);

  @override
  double get initialPosition {
    _$initialPositionAtom.reportRead();
    return super.initialPosition;
  }

  @override
  set initialPosition(double value) {
    _$initialPositionAtom.reportWrite(value, super.initialPosition, () {
      super.initialPosition = value;
    });
  }

  late final _$initialVelocityAtom =
      Atom(name: '_ParametersStoreBase.initialVelocity', context: context);

  @override
  double get initialVelocity {
    _$initialVelocityAtom.reportRead();
    return super.initialVelocity;
  }

  @override
  set initialVelocity(double value) {
    _$initialVelocityAtom.reportWrite(value, super.initialVelocity, () {
      super.initialVelocity = value;
    });
  }

  late final _$timeDeltaAtom =
      Atom(name: '_ParametersStoreBase.timeDelta', context: context);

  @override
  double get timeDelta {
    _$timeDeltaAtom.reportRead();
    return super.timeDelta;
  }

  @override
  set timeDelta(double value) {
    _$timeDeltaAtom.reportWrite(value, super.timeDelta, () {
      super.timeDelta = value;
    });
  }

  late final _$massAtom =
      Atom(name: '_ParametersStoreBase.mass', context: context);

  @override
  double get mass {
    _$massAtom.reportRead();
    return super.mass;
  }

  @override
  set mass(double value) {
    _$massAtom.reportWrite(value, super.mass, () {
      super.mass = value;
    });
  }

  late final _$dampingConstantAtom =
      Atom(name: '_ParametersStoreBase.dampingConstant', context: context);

  @override
  double get dampingConstant {
    _$dampingConstantAtom.reportRead();
    return super.dampingConstant;
  }

  @override
  set dampingConstant(double value) {
    _$dampingConstantAtom.reportWrite(value, super.dampingConstant, () {
      super.dampingConstant = value;
    });
  }

  late final _$springConstantAtom =
      Atom(name: '_ParametersStoreBase.springConstant', context: context);

  @override
  double get springConstant {
    _$springConstantAtom.reportRead();
    return super.springConstant;
  }

  @override
  set springConstant(double value) {
    _$springConstantAtom.reportWrite(value, super.springConstant, () {
      super.springConstant = value;
    });
  }

  @override
  String toString() {
    return '''
initialPosition: ${initialPosition},
initialVelocity: ${initialVelocity},
timeDelta: ${timeDelta},
mass: ${mass},
dampingConstant: ${dampingConstant},
springConstant: ${springConstant}
    ''';
  }
}
