import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class PositionGraph extends StatelessWidget with LayoutSlot {
  const PositionGraph({super.key});

  @override
  String get title => 'Graphs of position, velocity and acceleration';

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.transparent,
      child: Center(
        child: Text('Position graph'),
      ),
    );
  }
}
