import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/widgets/chart_legend.dart';
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
    final colors = Theme.of(context).colorScheme;

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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Flex(
        direction: switch (narrow) {
          true => Axis.vertical,
          false => Axis.horizontal,
        },
        children: [
          Expanded(
            child: LineChart(
              duration: Duration.zero,
              LineChartData(
                maxY: positionBounds * 1.1,
                minY: -positionBounds * 1.1,
                lineBarsData: [
                  LineChartBarData(
                    spots: positionPoints,
                    color: colors.primary,
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: velocityPoints,
                    color: colors.secondary,
                    dotData: const FlDotData(show: false),
                    dashArray: [10, 2],
                  ),
                  LineChartBarData(
                    spots: accelerationPoints,
                    color: colors.tertiary,
                    dotData: const FlDotData(show: false),
                    dashArray: [4, 2],
                  ),
                ],
                lineTouchData: LineTouchData(
                  getTouchedSpotIndicator: (data, indices) => List.filled(
                    indices.length,
                    TouchedSpotIndicatorData(
                      FlLine(color: colors.outline),
                      const FlDotData(),
                    ),
                  ),
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: colors.primaryContainer,
                    tooltipBorder: BorderSide(
                      color: colors.outline,
                    ),
                    tooltipRoundedRadius: 8,
                    maxContentWidth: 140,
                    showOnTopOfTheChartBoxArea: true,
                    getTooltipItems: (spots) => [
                      LineTooltipItem(
                        'Position: ${spots.firstWhere((s) => s.barIndex == 0).y.toStringAsFixed(2)}',
                        TextStyle(color: colors.primary),
                      ),
                      LineTooltipItem(
                        'Velocity: ${spots.firstWhere((s) => s.barIndex == 1).y.toStringAsFixed(2)}',
                        TextStyle(color: colors.secondary),
                      ),
                      LineTooltipItem(
                        'Acceleration: ${spots.firstWhere((s) => s.barIndex == 2).y.toStringAsFixed(2)}',
                        TextStyle(color: colors.tertiary),
                      ),
                    ],
                  ),
                ),
                borderData: FlBorderData(
                  border: Border.all(color: colors.outline),
                ),
              ),
            ),
          ),
          ChartLegend(
            entries: [
              LegendEntry(
                color: colors.primary,
                label: 'Position',
              ),
              LegendEntry(
                color: colors.secondary,
                label: 'Velocity',
                dashArray: const [10, 2],
              ),
              LegendEntry(
                color: colors.tertiary,
                label: 'Acceleration',
                dashArray: const [4, 2],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
