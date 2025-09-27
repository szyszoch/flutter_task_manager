import 'package:flutter/material.dart';
import 'package:flutter_task_manager/task.dart';
import 'package:intl/intl.dart';

class TaskDeadlineText extends StatelessWidget {
  final Task task;

  const TaskDeadlineText({super.key, required this.task});

  String _statusText() {
    if (task.isCompleted) {
      return 'Ukończone ${DateFormat('dd.MM.yyyy HH:mm').format(task.completedAt!)}';
    }
    if (task.isOverdue) {
      return 'Przeterminowane o ${task.leftTime}';
    }
    return '${task.leftTime} do terminu';
  }

  @override
  Widget build(BuildContext context) {
    final color = task.isCompleted
        ? Colors.green
        : task.isOverdue
        ? Colors.red
        : null;

    return Row(
      spacing: 6,
      children: [
        Icon(
          task.isCompleted
              ? Icons.check_circle
              : task.isOverdue
              ? Icons.error
              : Icons.access_time,
          size: 18,
          color: color,
        ),
        Expanded(
          child: Text(
            _statusText(),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
