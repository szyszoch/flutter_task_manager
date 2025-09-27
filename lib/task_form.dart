import 'package:flutter/material.dart';
import 'package:flutter_task_manager/database_helper.dart';
import 'package:flutter_task_manager/date_form_field.dart';
import 'package:flutter_task_manager/task.dart';
import 'package:flutter_task_manager/time_form_field.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

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
    if (_key.currentState!.validate()) {
      final newTask = Task(
        title: _title.text.trim(),
        description: _description.text.trim().isEmpty
            ? null
            : _description.text.trim(),
        deadline: _deadline!,
      );

      final createdTask = await DatabaseHelper.instance.createTask(newTask);

      if (!mounted) return;

      Navigator.of(context).pop(createdTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 20,

        children: [
          SizedBox(height: 1),
          TextFormField(
            autofocus: true,
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
            decoration: const InputDecoration(
              hintText: 'Opis (opcjonalnie)',
              labelText: 'Opis',
              alignLabelWithHint: true,
            ),
            maxLines: 4,
          ),

          DateFormField(
            value: _date,
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

          Row(
            spacing: 20,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  child: const Text('Anuluj'),
                ),
              ),

              Expanded(
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Dodaj'),
                ),
              ),
            ],
          ),

          SizedBox(height: 1),
        ],
      ),
    );
  }
}
