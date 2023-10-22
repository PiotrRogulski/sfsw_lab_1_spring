import 'package:flutter/material.dart';

class ConditionalWrapper extends StatelessWidget {
  const ConditionalWrapper({
    super.key,
    required this.enabled,
    required this.wrapper,
    required this.child,
  });

  final bool enabled;
  final Widget Function(Widget child) wrapper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return enabled ? wrapper(child) : child;
  }
}
