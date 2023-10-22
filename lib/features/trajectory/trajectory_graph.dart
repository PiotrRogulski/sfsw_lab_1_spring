import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/features/simulation/spring_simulation_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class TrajectoryGraph extends StatelessWidget with LayoutSlot {
  const TrajectoryGraph({super.key});

  @override
  String get title => 'Trajectory graph';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.hasBoundedHeight) {
          return const _TrajectoryGraph();
        } else {
          return const SizedBox(
            height: 400,
            child: _TrajectoryGraph(),
          );
        }
      },
    );
  }
}

class _TrajectoryGraph extends StatelessObserverWidget {
  const _TrajectoryGraph();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final SpringSimulationStore(
      :readings,
      trajectoryBounds: (:maxX, :maxY),
      :trajectoryPoints,
    ) = context.read();

    if (readings.isEmpty) {
      return const Placeholder(
        color: Colors.transparent,
        child: Center(
          child: Text('Trajectory graph'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        duration: Duration.zero,
        LineChartData(
          maxX: maxX * 1.1,
          minX: -maxX * 1.1,
          maxY: maxY * 1.1,
          minY: -maxY * 1.1,
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
              spots: trajectoryPoints,
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
          borderData: FlBorderData(
            border: Border.all(color: colors.outline),
          ),
          gridData: FlGridData(
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: colors.outline,
                strokeWidth: 0.4,
                dashArray: [8, 4],
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: colors.outline,
                strokeWidth: 0.4,
                dashArray: [8, 4],
              );
            },
          ),
        ),
      ),
    );
  }
}
