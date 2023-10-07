import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class TrajectoryGraph extends LayoutSlot {
  const TrajectoryGraph({super.key});

  @override
  String get title => 'Trajectory graph';

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.transparent,
      child: Center(
        child: Text('Trajectory graph'),
      ),
    );
  }
}
