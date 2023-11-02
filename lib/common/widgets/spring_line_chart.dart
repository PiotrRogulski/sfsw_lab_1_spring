import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/common/widgets/chart_legend.dart';

class SpringLineChart extends StatelessWidget {
  const SpringLineChart({
    super.key,
    required this.narrow,
    required this.yBounds,
    required this.firstDataSeries,
    required this.secondDataSeries,
    required this.thirdDataSeries,
    this.fourthDataSeries,
  });

  final bool narrow;
  final double yBounds;
  final ({String label, List<FlSpot> data}) firstDataSeries;
  final ({String label, List<FlSpot> data}) secondDataSeries;
  final ({String label, List<FlSpot> data}) thirdDataSeries;
  final ({String label, List<FlSpot> data})? fourthDataSeries;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
                maxY: yBounds * 1.1,
                minY: -yBounds * 1.1,
                lineBarsData: [
                  LineChartBarData(
                    spots: firstDataSeries.data,
                    color: colors.primary,
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: secondDataSeries.data,
                    color: colors.secondary,
                    dotData: const FlDotData(show: false),
                    dashArray: [10, 2],
                  ),
                  LineChartBarData(
                    spots: thirdDataSeries.data,
                    color: colors.tertiary,
                    dotData: const FlDotData(show: false),
                    dashArray: [4, 2],
                  ),
                  if (fourthDataSeries != null)
                    LineChartBarData(
                      spots: fourthDataSeries!.data,
                      color: colors.error,
                      dotData: const FlDotData(show: false),
                      dashArray: [4, 2, 2, 2],
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
                    // showOnTopOfTheChartBoxArea: true,
                    getTooltipItems: (spots) => [
                      LineTooltipItem(
                        '${firstDataSeries.label}: ${spots.firstWhere((s) => s.barIndex == 0).y.toStringAsFixed(2)}',
                        TextStyle(color: colors.primary),
                      ),
                      LineTooltipItem(
                        '${secondDataSeries.label}: ${spots.firstWhere((s) => s.barIndex == 1).y.toStringAsFixed(2)}',
                        TextStyle(color: colors.secondary),
                      ),
                      LineTooltipItem(
                        '${thirdDataSeries.label}: ${spots.firstWhere((s) => s.barIndex == 2).y.toStringAsFixed(2)}',
                        TextStyle(color: colors.tertiary),
                      ),
                      if (fourthDataSeries != null)
                        LineTooltipItem(
                          '${fourthDataSeries!.label}: ${spots.firstWhere((s) => s.barIndex == 3).y.toStringAsFixed(2)}',
                          TextStyle(color: colors.error),
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
                label: firstDataSeries.label,
              ),
              LegendEntry(
                color: colors.secondary,
                label: secondDataSeries.label,
                dashArray: const [10, 2],
              ),
              LegendEntry(
                color: colors.tertiary,
                label: thirdDataSeries.label,
                dashArray: const [4, 2],
              ),
              if (fourthDataSeries case final series?)
                LegendEntry(
                  color: colors.error,
                  label: series.label,
                  dashArray: const [4, 2, 2, 2],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
