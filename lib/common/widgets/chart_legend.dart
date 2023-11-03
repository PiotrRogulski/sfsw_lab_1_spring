import 'package:flutter/material.dart';

class ChartLegend extends StatelessWidget {
  const ChartLegend({
    super.key,
    required this.entries,
  });

  final List<LegendEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: entries,
    );
  }
}

class LegendEntry extends StatelessWidget {
  const LegendEntry({
    super.key,
    required this.color,
    required this.label,
    this.dashArray,
  });

  final Color color;
  final String label;
  final List<double>? dashArray;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 8,
            child: CustomPaint(
              painter: _LinePreviewPainter(
                color: color,
                dashArray: dashArray,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class _LinePreviewPainter extends CustomPainter {
  _LinePreviewPainter({
    required this.color,
    this.dashArray,
  });

  final Color color;
  final List<double>? dashArray;

  late final dashPaint = Paint()
    ..color = color
    ..strokeWidth = 2
    ..style = PaintingStyle.fill
    ..isAntiAlias = false;

  @override
  void paint(Canvas canvas, Size size) {
    final middle = size.height / 2;

    if (dashArray case final dashArray?) {
      var x = 0.0;
      var i = 0;
      while (x < size.width) {
        if (i.isEven) {
          canvas.drawLine(
            Offset(x, middle),
            Offset(x + dashArray[i], middle),
            dashPaint,
          );
        }
        x += dashArray[i];
        i = (i + 1) % dashArray.length;
      }
    } else {
      canvas.drawLine(
        Offset(0, middle),
        Offset(size.width, middle),
        dashPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_LinePreviewPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.dashArray?.firstOrNull != dashArray?.firstOrNull ||
      oldDelegate.dashArray?.lastOrNull != dashArray?.lastOrNull;
}
