import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_store.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => ParametersStore(),
        ),
      ],
      child: child,
    );
  }
}
