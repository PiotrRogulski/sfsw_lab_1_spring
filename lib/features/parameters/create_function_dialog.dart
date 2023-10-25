import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sfsw_lab_1_spring/common/extensions/list.dart';
import 'package:sfsw_lab_1_spring/features/parameters/functional_parameter.dart';

class CreateFunctionDialog<T extends FunctionalParameter> extends HookWidget {
  const CreateFunctionDialog._({
    super.key,
    required this.formula,
    required this.variables,
    this.variableValues,
  });

  final String formula;
  final List<String> variables;
  final Map<String, double>? variableValues;

  static Future<T?> show<T extends FunctionalParameter>(
    BuildContext context, {
    required List<String> variables,
    Map<String, double>? variableValues,
    required String formula,
    required T Function(Map<String, double> vars) builder,
  }) async {
    final values = await showDialog<Map<String, double>>(
      context: context,
      builder: (context) {
        return CreateFunctionDialog._(
          formula: formula,
          variables: variables,
          variableValues: variableValues,
        );
      },
    );
    if (values != null) {
      return builder(values);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controllers = List.generate(
      variables.length,
      (index) => useTextEditingController(
        text: variableValues?[variables[index]]?.toStringAsFixed(2),
      ),
    );

    final focusNodes = useMemoized(
      () => List.generate(variables.length, (index) => FocusNode()),
    );

    final formKey = useMemoized(GlobalKey<FormState>.new);

    return AlertDialog(
      title: Text(formula),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < variables.length; i++)
              TextFormField(
                autofocus: i == 0,
                controller: controllers[i],
                focusNode: focusNodes[i],
                decoration: InputDecoration(
                  labelText: variables[i],
                  errorStyle: const TextStyle(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: i == variables.length - 1
                    ? TextInputAction.done
                    : TextInputAction.next,
                onFieldSubmitted: (value) {
                  if (i < variables.length - 1) {
                    focusNodes[i + 1].requestFocus();
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
              ),
          ].spaced(height: 16),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final values = <String, double>{};
              for (var i = 0; i < variables.length; i++) {
                values[variables[i]] = double.parse(controllers[i].text);
              }
              Navigator.of(context).pop(values);
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
