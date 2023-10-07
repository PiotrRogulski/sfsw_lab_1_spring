import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class ParametersForm extends LayoutSlot {
  const ParametersForm({super.key});

  @override
  String get title => 'Spring parameters';

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.transparent,
      child: Center(
        child: Text('Spring parameters'),
      ),
    );
  }
}
