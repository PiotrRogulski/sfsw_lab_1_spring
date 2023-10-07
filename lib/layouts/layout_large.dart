import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/common/extensions/list.dart';
import 'package:sfsw_lab_1_spring/features/forces/forces_graph.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_form.dart';
import 'package:sfsw_lab_1_spring/features/position/position_graph.dart';
import 'package:sfsw_lab_1_spring/features/trajectory/trajectory_graph.dart';
import 'package:sfsw_lab_1_spring/features/visualization/spring_visualization.dart';
import 'package:sfsw_lab_1_spring/layouts/slot_decoration.dart';

class LayoutLarge extends StatelessWidget {
  const LayoutLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const SizedBox(
            width: 200,
            child: SlotDecoration(child: ParametersForm()),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: SlotDecoration(child: SpringVisualization()),
                ),
                const Expanded(
                  child: SlotDecoration(child: PositionGraph()),
                ),
              ].spaced(height: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Expanded(
                  child: SlotDecoration(child: ForcesGraph()),
                ),
                const Expanded(
                  flex: 2,
                  child: SlotDecoration(child: TrajectoryGraph()),
                ),
              ].spaced(height: 16),
            ),
          ),
        ].spaced(width: 16),
      ),
    );
  }
}
