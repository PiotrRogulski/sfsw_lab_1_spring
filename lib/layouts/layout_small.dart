import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/common/extensions/list.dart';
import 'package:sfsw_lab_1_spring/features/forces/forces_graph.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_form.dart';
import 'package:sfsw_lab_1_spring/features/position/position_graph.dart';
import 'package:sfsw_lab_1_spring/features/trajectory/trajectory_graph.dart';
import 'package:sfsw_lab_1_spring/features/visualization/spring_visualization.dart';
import 'package:sfsw_lab_1_spring/layouts/slot_decoration.dart';

class LayoutSmall extends StatelessWidget {
  const LayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.paddingOf(context).copyWith(top: 0);

    return ListView(
      padding: const EdgeInsets.all(16) + safeArea,
      // TODO: adjust children sizes
      children: const [
        SlotDecoration(child: SpringVisualization()),
        SlotDecoration(child: ParametersForm()),
        SlotDecoration(child: ForcesGraph()),
        SlotDecoration(child: TrajectoryGraph()),
        SlotDecoration(child: PositionGraph()),
      ].spaced(height: 16),
    );
  }
}
