import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class SpringVisualization extends LayoutSlot {
  const SpringVisualization({super.key});

  @override
  String get title => 'Spring visualization';

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.transparent,
      child: Center(
        child: Text('Spring visualization'),
      ),
    );
  }
}
