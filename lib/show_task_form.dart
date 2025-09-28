import 'package:flutter/material.dart';
import 'package:flutter_task_manager/task.dart';
import 'package:flutter_task_manager/task_form.dart';

Future<bool> showTaskForm(BuildContext context, [Task? task]) async {
  final int? result = await showModalBottomSheet(
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

  return result != null && result > 0;
}
