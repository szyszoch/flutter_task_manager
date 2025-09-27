import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends FormField<DateTime?> {
  final ValueChanged<DateTime?> onDateChanged;
  final DateTime? value;

  DateFormField({
    super.key,
    this.value,
    required this.onDateChanged,
    super.validator,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         initialValue: value,
         builder: (state) {
           final effectiveValue = value ?? state.value;

           return _DatePicker(
             state: state,
             value: effectiveValue,
             onDateChanged: onDateChanged,
           );
         },
       );
}

class _DatePicker extends StatelessWidget {
  const _DatePicker({
    required this.state,
    required this.value,
    required this.onDateChanged,
  });

  final FormFieldState<DateTime?> state;
  final DateTime? value;
  final ValueChanged<DateTime?> onDateChanged;

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      state.didChange(pickedDate);
      onDateChanged(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickDate(context),
          icon: const Icon(Icons.calendar_today),
          label: Text(
            value == null
                ? 'Wybierz datę'
                : DateFormat('dd.MM.yyyy').format(value!),
          ),
        ),
        if (state.hasError)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              state.errorText!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12.0,
              ),
            ),
          ),
      ],
    );
  }
}
