import 'package:flutter/material.dart';
import 'package:flutter_task_manager/task.dart';
import 'package:flutter_task_manager/task_form.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future<void> showTaskFormBottomSheet(BuildContext context) async {
    final newTask = await showModalBottomSheet<Task>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            top: 20.0,
            right: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(child: TaskForm()),
        ),
      ),
    );

    if (newTask != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Pomyślnie dodano zadanie.')));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Twoje zadania')),

      floatingActionButton: FloatingActionButton(
        onPressed: () => showTaskFormBottomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
