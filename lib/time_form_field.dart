import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormField extends FormField<TimeOfDay?> {
  final ValueChanged<TimeOfDay?> onTimeChanged;

  TimeFormField({
    super.key,
    super.initialValue,
    required this.onTimeChanged,
    super.validator,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         builder: (state) =>
             _TimePicker(state: state, onTimeChanged: onTimeChanged),
       );
}

class _TimePicker extends StatefulWidget {
  final FormFieldState<TimeOfDay?> state;
  final ValueChanged<TimeOfDay?> onTimeChanged;

  const _TimePicker({required this.state, required this.onTimeChanged});

  @override
  State<_TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<_TimePicker> {
  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: widget.state.value ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      widget.state.didChange(pickedTime);
      widget.onTimeChanged(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        ElevatedButton.icon(
          onPressed: _pickTime,
          icon: const Icon(Icons.access_time),
          label: Text(
            widget.state.value == null
                ? 'Wybierz czas'
                : widget.state.value!.format(context),
          ),
        ),

        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
