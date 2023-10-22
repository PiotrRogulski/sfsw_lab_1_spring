import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/widgets/spring_line_chart.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class PositionGraph extends StatelessWidget with LayoutSlot {
  const PositionGraph({super.key});

  @override
  String get title => 'Graphs of position, velocity and acceleration';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 400;

        if (constraints.hasBoundedHeight) {
          return _PositionGraph(narrow: narrow);
        } else {
          return SizedBox(
            height: switch (narrow) {
              true => 400,
              false => 200,
            },
            child: _PositionGraph(narrow: narrow),
          );
        }
      },
    );
  }
}

class _PositionGraph extends StatelessObserverWidget {
  const _PositionGraph({
    required this.narrow,
  });

  final bool narrow;

  @override
  Widget build(BuildContext context) {
    final SpringSimulationStore(
      :readings,
      :positionBounds,
      :positionPoints,
      :velocityPoints,
      :accelerationPoints,
    ) = context.read();

    if (readings.isEmpty) {
      return const Placeholder(
        color: Colors.transparent,
        child: Center(
          child: Text('Position graph'),
        ),
      );
    }

    return SpringLineChart(
      narrow: narrow,
      yBounds: positionBounds,
      firstDataSeries: (
        label: 'Position',
        data: positionPoints,
      ),
      secondDataSeries: (
        label: 'Velocity',
        data: velocityPoints,
      ),
      thirdDataSeries: (
        label: 'Acceleration',
        data: accelerationPoints,
      ),
    );
  }
}
