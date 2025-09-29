import 'package:flutter/material.dart';
import 'package:flutter_task_manager/models/task.dart';

Future<bool?> showDeleteTaskConfirmation(BuildContext context, Task task) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Potwierdź usunięcie'),
      content: Text('Usunąć zadanie "${task.title}"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Anuluj'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Usuń'),
        ),
      ],
    ),
  );
}
