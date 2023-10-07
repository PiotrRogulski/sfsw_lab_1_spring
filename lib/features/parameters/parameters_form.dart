import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sfsw_lab_1_spring/common/hooks/use_reaction.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameter_store.dart';
import 'package:sfsw_lab_1_spring/features/parameters/parameters_store.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class ParametersForm extends LayoutSlot {
  const ParametersForm({super.key});

  @override
  String get title => 'Spring parameters';

  @override
  Widget build(BuildContext context) {
    final parameters = context.read<ParametersStore>();

    return SingleChildScrollView(
      child: Column(
        children: [
          _ParameterEntry(
            label: 'm',
            parameter: parameters.mass,
          ),
        ],
      ),
    );
  }
}

class _ParameterEntry extends HookWidget {
  const _ParameterEntry({
    required this.label,
    required this.parameter,
  });

  final String label;
  final ParameterStore parameter;

  @override
  Widget build(BuildContext context) {
    final controller =
        useTextEditingController(text: parameter.value.toStringAsFixed(2));

    useReaction(
      () => parameter.value,
      (value) => controller.text = value.toStringAsFixed(2),
    );

    return Observer(
      builder: (context) {
        return Row(
          children: [
            const SizedBox(width: 8),
            SizedBox(
              width: 32,
              child: Text(
                label,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 64,
              child: TextFormField(
                controller: controller,
                onFieldSubmitted: (value) {
                  final parsed = double.tryParse(value);
                  if (parsed != null) {
                    parameter.value = parsed;
                  }
                },
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return '';
                  }
                  final parsed = double.parse(value);
                  if (parsed < parameter.bounds.min ||
                      parsed > parameter.bounds.max) {
                    return '';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Expanded(
              child: Slider(
                value: parameter.value,
                onChanged: (value) => parameter.value = value,
                min: parameter.bounds.min,
                max: parameter.bounds.max,
                inactiveColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        );
      },
    );
  }
}
