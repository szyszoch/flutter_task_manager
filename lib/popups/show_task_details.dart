import 'package:flutter/material.dart';
import 'package:flutter_task_manager/widgets/task_deadline_text.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

void showTaskDetailsDialog(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(task.title),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TaskDeadlineText(task: task, hasIcon: true),

              Text(
                'Termin: ${DateFormat('dd.MM.yyyy HH:mm').format(task.deadline)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const SizedBox(height: 8),

              if (task.description?.isNotEmpty ?? false)
                Text(
                  task.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              else
                Center(
                  child: Text(
                    'Brak opisu',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Zamknij'),
        ),
      ],
    ),
  );
}
