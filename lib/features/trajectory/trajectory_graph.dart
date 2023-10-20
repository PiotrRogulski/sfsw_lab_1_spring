import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class TrajectoryGraph extends LayoutSlot {
  const TrajectoryGraph({super.key});

  @override
  String get title => 'Trajectory graph';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final simulationStore = context.read<SpringSimulationStore>();

    return Observer(
      builder: (context) {
        final data =
            simulationStore.readings.map((o) => (x: o.position, y: o.velocity));

        if (data.isEmpty) {
          return const Placeholder(
            color: Colors.transparent,
            child: Center(
              child: Text('Trajectory graph'),
            ),
          );
        }

        final maxX = data.map((o) => o.x.abs()).max * 1.1;
        final maxY = data.map((o) => o.y.abs()).max * 1.1;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: LineChart(
            duration: Duration.zero,
            LineChartData(
              maxX: maxX,
              minX: -maxX,
              maxY: maxY,
              minY: -maxY,
              titlesData: const FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameSize: 24,
                  axisNameWidget: Text('Position'),
                ),
                leftTitles: AxisTitles(
                  axisNameSize: 24,
                  axisNameWidget: Text('Velocity'),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [for (final (:x, :y) in data) FlSpot(x, y)],
                  color: colors.primary,
                  dotData: const FlDotData(show: false),
                ),
              ],
              lineTouchData: LineTouchData(
                distanceCalculator: (touch, spot) => (touch - spot).distance,
                getTouchedSpotIndicator: (data, indices) => List.filled(
                  indices.length,
                  const TouchedSpotIndicatorData(
                    FlLine(strokeWidth: 0),
                    FlDotData(),
                  ),
                ),
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: colors.primaryContainer,
                  tooltipBorder: BorderSide(
                    color: colors.outline,
                  ),
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (spots) => [
                    for (final spot in spots)
                      LineTooltipItem(
                        'Position: ${spot.x.toStringAsFixed(2)}'
                        '\nVelocity: ${spot.y.toStringAsFixed(2)}',
                        TextStyle(color: colors.onPrimaryContainer),
                      ),
                  ],
                ),
              ),
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: 0,
                    color: colors.primary.withOpacity(0.5),
                    strokeWidth: 1,
                  ),
                ],
                verticalLines: [
                  VerticalLine(
                    x: 0,
                    color: colors.primary.withOpacity(0.5),
                    strokeWidth: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
