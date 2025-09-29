import 'package:flutter/material.dart';
import 'package:flutter_task_manager/widgets/form_error_text.dart';

class TimeFormField extends FormField<TimeOfDay?> {
  final ValueChanged<TimeOfDay?> onTimeChanged;
  final TimeOfDay? value;

  TimeFormField({
    super.key,
    this.value,
    required this.onTimeChanged,
    super.validator,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         initialValue: value,
         builder: (state) {
           return _TimePicker(
             state: state,
             value: state.value,
             onTimeChanged: onTimeChanged,
           );
         },
       );
}

class _TimePicker extends StatelessWidget {
  const _TimePicker({
    required this.state,
    required this.value,
    required this.onTimeChanged,
  });

  final FormFieldState<TimeOfDay?> state;
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?> onTimeChanged;

  Future<void> _pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: value ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      state.didChange(pickedTime);
      onTimeChanged(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String label = value == null
        ? 'Wybierz czas'
        : value!.format(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickTime(context),
          icon: const Icon(Icons.access_time),
          label: Text(label),
        ),
        if (state.hasError)
          buildFormErrorText(context, state.errorText!, isCustomField: true),
      ],
    );
  }
}
