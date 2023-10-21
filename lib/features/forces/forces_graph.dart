import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class ForcesGraph extends StatelessWidget with LayoutSlot {
  const ForcesGraph({super.key});

  @override
  String get title => 'Graphs of forces';

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.transparent,
      child: Center(
        child: Text('Forces graph'),
      ),
    );
  }
}
