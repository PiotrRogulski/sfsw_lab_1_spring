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
    final safeArea = MediaQuery.paddingOf(context).copyWith(top: 0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16) + safeArea.copyWith(right: 0),
          child: const SizedBox(
            width: 250,
            child: SlotDecoration(child: ParametersForm()),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
                  right: 16,
                  top: 16,
                  bottom: 16,
                ) +
                safeArea.copyWith(left: 0),
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
