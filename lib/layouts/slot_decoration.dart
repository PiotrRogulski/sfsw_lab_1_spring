import 'package:flutter/material.dart';

class SlotDecoration extends StatelessWidget {
  const SlotDecoration({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: child,
    );
  }
}
