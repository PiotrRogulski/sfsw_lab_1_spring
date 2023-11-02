part of 'parameters_form.dart';

class _LatestReading extends StatelessWidget {
  const _LatestReading({
    required this.reading,
  });

  final Observation reading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FixedColumnWidth(16),
          2: FlexColumnWidth(),
        },
        children: [
          _ReadingRow(
            label: 'Timestamp',
            value: reading.timestamp.inMilliseconds /
                Duration.millisecondsPerSecond,
          ),
          TableRow(
            children: List.filled(
              3,
              Divider(color: colors.outline),
            ),
          ),
          _ReadingRow(
            label: 'Position',
            value: reading.position,
          ),
          _ReadingRow(
            label: 'Origin',
            value: reading.origin,
          ),
          _ReadingRow(
            label: 'Velocity',
            value: reading.velocity,
          ),
          _ReadingRow(
            label: 'Acceleration',
            value: reading.acceleration,
          ),
          _ReadingRow(
            label: 'Spring force',
            value: reading.springForce,
          ),
          _ReadingRow(
            label: 'Damping force',
            value: reading.dampingForce,
          ),
          _ReadingRow(
            label: 'External force',
            value: reading.externalForce,
          ),
        ],
      ),
    );
  }
}

class _ReadingRow extends TableRow {
  _ReadingRow({
    required this.label,
    required this.value,
  }) : super(
          children: [
            Builder(
              builder: (context) {
                return Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge,
                );
              },
            ),
            const SizedBox.shrink(),
            Text(value.toStringAsFixed(2)),
          ],
        );

  final String label;
  final double value;
}
