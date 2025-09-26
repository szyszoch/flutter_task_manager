import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends FormField<DateTime?> {
  final ValueChanged<DateTime?> onDateChanged;

  DateFormField({
    super.key,
    super.initialValue,
    required this.onDateChanged,
    super.validator,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         builder: (state) =>
             _DatePicker(state: state, onDateChanged: onDateChanged),
       );
}

class _DatePicker extends StatefulWidget {
  const _DatePicker({required this.state, required this.onDateChanged});

  final FormFieldState<DateTime?> state;
  final ValueChanged<DateTime?> onDateChanged;

  @override
  State<_DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.state.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      widget.state.didChange(pickedDate);
      widget.onDateChanged(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        ElevatedButton.icon(
          onPressed: _pickDate,
          icon: const Icon(Icons.calendar_today),
          label: Text(
            widget.state.value == null
                ? 'Wybierz datę'
                : DateFormat('dd.MM.yyyy').format(widget.state.value!),
          ),
        ),

        if (widget.state.hasError)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.state.errorText!,
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
