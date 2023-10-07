import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/common/extensions/list.dart';
import 'package:sfsw_lab_1_spring/features/forces/forces_graph.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_form.dart';
import 'package:sfsw_lab_1_spring/features/position/position_graph.dart';
import 'package:sfsw_lab_1_spring/features/trajectory/trajectory_graph.dart';
import 'package:sfsw_lab_1_spring/features/visualization/spring_visualization.dart';
import 'package:sfsw_lab_1_spring/layouts/slot_decoration.dart';

class LayoutMedium extends StatelessWidget {
  const LayoutMedium({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: 200,
            child: SlotDecoration(child: ParametersForm()),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
              right: 16,
              top: 16,
              bottom: 16,
            ),
            // TODO: adjust children sizes
            children: const [
              SlotDecoration(child: SpringVisualization()),
              SlotDecoration(child: ForcesGraph()),
              SlotDecoration(child: TrajectoryGraph()),
              SlotDecoration(child: PositionGraph()),
            ].spaced(height: 16),
          ),
        ),
      ],
    );
  }
}
