import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/common/extensions/iterable.dart';

extension WidgetListX on List<Widget> {
  List<Widget> spaced({
    double width = 0,
    double height = 0,
  }) =>
      intersperse(SizedBox(width: width, height: height)).toList();
}
