part of './parameters_form.dart';

class _ParameterEntry extends HookWidget {
  const _ParameterEntry({
    required this.label,
    required this.description,
    required this.parameter,
  });

  final String label;
  final String description;
  final ParameterStore parameter;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    final ParameterStore(:precision, :bounds) = parameter;

    final controller = useTextEditingController(
      text: parameter.value.toStringAsFixed(precision),
    );

    useReaction(
      () => parameter.value,
      (value) => controller.text = value.toStringAsFixed(precision),
    );

    // ignore: avoid_types_on_closure_parameters
    final validator = useCallback((String? value) {
      if (value == null || double.tryParse(value) == null) {
        return '';
      }
      final parsed = double.parse(value);
      if (parsed < bounds.min || parsed > bounds.max) {
        return '';
      }
      return null;
    });

    final enabled = useObservable(
      () =>
          context.read<SpringSimulationStore>().status !=
          SimulationStatus.running,
    );

    final currentValue = useObservable(() => parameter.value);

    return Row(
      children: [
        const SizedBox(width: 8),
        SizedBox(
          width: 32,
          child: MouseRegion(
            cursor: SystemMouseCursors.help,
            child: Tooltip(
              preferBelow: false,
              message: description,
              textStyle: textStyles.bodySmall?.copyWith(
                color: colors.onInverseSurface,
              ),
              decoration: BoxDecoration(
                color: colors.inverseSurface,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                label,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        SizedBox(
          width: 64,
          child: TextFormField(
            enabled: enabled,
            controller: controller,
            onFieldSubmitted: (value) {
              final parsed = double.tryParse(value);
              if (parsed != null && validator(value) == null) {
                parameter.value = parsed;
              } else {
                controller.text = currentValue.toStringAsFixed(precision);
              }
            },
            autovalidateMode: AutovalidateMode.always,
            validator: validator,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        Expanded(
          child: Slider(
            value: currentValue,
            onChanged: enabled ? (value) => parameter.value = value : null,
            min: bounds.min,
            max: bounds.max,
            inactiveColor: Theme.of(context).colorScheme.surface,
          ),
        ),
      ],
    );
  }
}
