import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sfsw_lab_1_spring/features/parameters/create_function_dialog.dart';
import 'package:sfsw_lab_1_spring/features/parameters/functional_parameter.dart';

class FunctionalParameterButton extends HookWidget {
  const FunctionalParameterButton({
    super.key,
    required this.label,
    required this.parameterValue,
    required this.parameterSetter,
  });

  final String label;
  final FunctionalParameter parameterValue;
  final void Function(FunctionalParameter parameter) parameterSetter;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    final menuController = useMemoized(MenuController.new);
    useEffect(() => menuController.close, [menuController]);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTapUp: (event) {
            menuController.open(position: event.localPosition);
          },
          child: MenuAnchor(
            controller: menuController,
            anchorTapClosesMenu: true,
            menuChildren: [
              _FunctionMenuEntry(
                label: 'Constant',
                currentValue: parameterValue,
                setupData: ConstantParameter.setupData,
                parameterSetter: parameterSetter,
              ),
              _FunctionMenuEntry(
                label: 'Sinusoidal',
                currentValue: parameterValue,
                setupData: SinusoidalParameter.setupData,
                parameterSetter: parameterSetter,
              ),
              _FunctionMenuEntry(
                label: 'Square wave',
                currentValue: parameterValue,
                setupData: SquareWaveParameter.setupData,
                parameterSetter: parameterSetter,
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: textStyles.titleSmall,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.edit,
                        color: colors.onBackground,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    parameterValue.formula,
                    style: textStyles.labelSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FunctionMenuEntry<T extends FunctionalParameter>
    extends StatelessWidget {
  const _FunctionMenuEntry({
    super.key,
    required this.label,
    required this.currentValue,
    required this.setupData,
    required this.parameterSetter,
  });

  final String label;
  final FunctionalParameter currentValue;
  final ParameterSetupData<T> setupData;
  final void Function(T parameter) parameterSetter;

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () async {
        final newParameter = await CreateFunctionDialog.show<T>(
          context,
          variables: setupData.variables,
          variableValues: switch (currentValue) {
            T(:final variableValues) => variableValues,
            _ => null,
          },
          formula: setupData.formula,
          builder: setupData.builder,
        );
        if (newParameter != null) {
          parameterSetter(newParameter);
        }
      },
      trailingIcon: switch (currentValue) {
        T() => const Icon(Icons.check),
        _ => null,
      },
      child: Text(label),
    );
  }
}
