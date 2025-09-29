import 'package:flutter/material.dart';
import 'package:flutter_task_manager/widgets/date_form_field.dart';
import 'package:flutter_task_manager/widgets/form_actions.dart';
import 'package:flutter_task_manager/widgets/form_error_text.dart';
import 'package:flutter_task_manager/models/task.dart';
import 'package:flutter_task_manager/widgets/time_form_field.dart';

class TaskForm extends StatefulWidget {
  final Task? task;

  const TaskForm({super.key, this.task});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  DateTime? _date;
  TimeOfDay? _time;

  @override
  void initState() {
    super.initState();
    final t = widget.task;
    if (t != null) {
      _title.text = t.title;
      _description.text = t.description ?? '';
      _date = DateTime(t.deadline.year, t.deadline.month, t.deadline.day);
      _time = TimeOfDay(hour: t.deadline.hour, minute: t.deadline.minute);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  DateTime? get _deadline {
    if (_date == null) return null;
    final time = _time ?? const TimeOfDay(hour: 23, minute: 59);
    return DateTime(
      _date!.year,
      _date!.month,
      _date!.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _submit() async {
    if (!_key.currentState!.validate()) return;
    final bool isEditing = widget.task != null;
    final Task task = Task(
      id: isEditing ? widget.task!.id : null,
      title: _title.text.trim(),
      description: _description.text.trim().isEmpty
          ? null
          : _description.text.trim(),
      deadline: _deadline!,
    );
    if (mounted) Navigator.of(context).pop(task);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    return Form(
      key: _key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 20,
        children: [
          const SizedBox(height: 1),
          TextFormField(
            autofocus: true,
            errorBuilder: buildFormErrorText,
            controller: _title,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Tytuł jest wymagany';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Tytuł',
              labelText: 'Tytuł',
            ),
          ),

          TextFormField(
            controller: _description,
            errorBuilder: buildFormErrorText,
            decoration: const InputDecoration(
              hintText: 'Opis (opcjonalnie)',
              labelText: 'Opis',
              alignLabelWithHint: true,
            ),
            maxLines: 4,
          ),

          DateFormField(
            value: _date,
            preventPastDate: true,
            onDateChanged: (value) {
              setState(() {
                _date = value;

                if (_date != null && _time == null) {
                  _time = const TimeOfDay(hour: 23, minute: 59);
                }
              });
            },
            validator: (value) {
              if (value == null) return 'Termin jest wymagany';
              return null;
            },
          ),

          TimeFormField(
            value: _time,
            onTimeChanged: (value) {
              setState(() {
                _time = value;

                if (_time != null && _date == null) {
                  final now = DateTime.now();
                  _date = DateTime(now.year, now.month, now.day);
                }
              });
            },
            validator: (value) {
              if (_deadline == null) return null;
              if (_deadline!.isBefore(DateTime.now())) {
                return 'Nie można wybrać przeszłego czasu';
              }
              return null;
            },
          ),

          FormActions(
            isEditing: isEditing,
            onCancel: () => Navigator.of(context).pop(null),
            onSubmit: _submit,
          ),

          const SizedBox(height: 1),
        ],
      ),
    );
  }
}
