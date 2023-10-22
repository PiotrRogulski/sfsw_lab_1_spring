import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/widgets/spring_line_chart.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class ForcesGraph extends StatelessWidget with LayoutSlot {
  const ForcesGraph({super.key});

  @override
  String get title => 'Graphs of forces';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 350;

        if (constraints.hasBoundedHeight) {
          return _ForcesGraph(narrow: narrow);
        } else {
          return SizedBox(
            height: switch (narrow) {
              true => 400,
              false => 200,
            },
            child: _ForcesGraph(narrow: narrow),
          );
        }
      },
    );
  }
}

class _ForcesGraph extends StatelessObserverWidget {
  const _ForcesGraph({
    required this.narrow,
  });

  final bool narrow;

  @override
  Widget build(BuildContext context) {
    final SpringSimulationStore(
      :readings,
      :forcesBounds,
      :springForcePoints,
      :dampingForcePoints,
      :externalForcePoints,
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
      yBounds: forcesBounds,
      firstDataSeries: (
        label: 'Spring',
        data: springForcePoints,
      ),
      secondDataSeries: (
        label: 'Damping',
        data: dampingForcePoints,
      ),
      thirdDataSeries: (
        label: 'External',
        data: externalForcePoints,
      ),
    );
  }
}
