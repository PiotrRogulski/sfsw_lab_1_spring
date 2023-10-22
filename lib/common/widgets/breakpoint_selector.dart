import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class BreakpointSelector extends StatelessWidget {
  const BreakpointSelector({
    super.key,
    required this.builders,
  });

  final Map<Breakpoint?, WidgetBuilder> builders;

  @override
  Widget build(BuildContext context) {
    final builder = builders.entries
            .firstWhereOrNull((entry) => entry.key?.isActive(context) ?? false)
            ?.value ??
        builders[null]!;

    return builder(context);
  }
}

enum AppBreakpoint implements Breakpoint {
  small(end: 700),
  medium(begin: 700, end: 1200),
  large(begin: 1200);

  const AppBreakpoint({
    this.begin = double.negativeInfinity,
    this.end = double.infinity,
  });

  final double begin;
  final double end;

  @override
  bool isActive(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return width >= begin && width < end;
  }
}
