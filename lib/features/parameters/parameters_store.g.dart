// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameters_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ParametersStore on _ParametersStoreBase, Store {
  late final _$externalForceAtom =
      Atom(name: '_ParametersStoreBase.externalForce', context: context);

  @override
  FunctionalParameter get externalForce {
    _$externalForceAtom.reportRead();
    return super.externalForce;
  }

  @override
  set externalForce(FunctionalParameter value) {
    _$externalForceAtom.reportWrite(value, super.externalForce, () {
      super.externalForce = value;
    });
  }

  late final _$originPositionAtom =
      Atom(name: '_ParametersStoreBase.originPosition', context: context);

  @override
  FunctionalParameter get originPosition {
    _$originPositionAtom.reportRead();
    return super.originPosition;
  }

  @override
  set originPosition(FunctionalParameter value) {
    _$originPositionAtom.reportWrite(value, super.originPosition, () {
      super.originPosition = value;
    });
  }

  @override
  String toString() {
    return '''
externalForce: ${externalForce},
originPosition: ${originPosition}
    ''';
  }
}
