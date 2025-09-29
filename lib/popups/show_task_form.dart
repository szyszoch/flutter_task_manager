import 'package:flutter/material.dart';
import 'package:flutter_task_manager/models/task.dart';
import 'package:flutter_task_manager/widgets/task_form.dart';

Future<Task?> showTaskForm(BuildContext context, [Task? task]) async {
  return await showModalBottomSheet<Task?>(
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
        child: SingleChildScrollView(child: TaskForm(task: task)),
      ),
    ),
  );
}
