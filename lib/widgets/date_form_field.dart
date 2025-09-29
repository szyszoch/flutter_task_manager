import 'package:flutter/material.dart';
import 'package:flutter_task_manager/widgets/form_error_text.dart';
import 'package:intl/intl.dart';

class DateFormField extends FormField<DateTime?> {
  final ValueChanged<DateTime?> onDateChanged;
  final DateTime? value;
  final bool preventPastDate;

  DateFormField({
    super.key,
    this.value,
    required this.onDateChanged,
    super.validator,
    this.preventPastDate = false,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         initialValue: value,
         builder: (state) {
           return _DatePicker(
             state: state,
             value: state.value,
             onDateChanged: onDateChanged,
             preventPastDate: preventPastDate,
           );
         },
       );
}

class _DatePicker extends StatelessWidget {
  const _DatePicker({
    required this.state,
    required this.value,
    required this.onDateChanged,
    this.preventPastDate = false,
  });

  final FormFieldState<DateTime?> state;
  final DateTime? value;
  final ValueChanged<DateTime?> onDateChanged;
  final bool preventPastDate;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: value != null && value!.isAfter(now) ? value! : now,
      firstDate: preventPastDate ? now : DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      state.didChange(pickedDate);
      onDateChanged(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String label = value == null
        ? 'Wybierz datę'
        : DateFormat('dd.MM.yyyy').format(value!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickDate(context),
          icon: const Icon(Icons.calendar_today),
          label: Text(label),
        ),
        if (state.hasError)
          buildFormErrorText(context, state.errorText!, isCustomField: true),
      ],
    );
  }
}
