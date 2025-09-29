import 'package:flutter/material.dart';
import 'package:flutter_task_manager/widgets/action_icon.dart';
import 'package:flutter_task_manager/widgets/animated_size_and_fade.dart';
import 'package:flutter_task_manager/helpers/database_helper.dart';
import 'package:flutter_task_manager/popups/show_delete_task_confirmation.dart';
import 'package:flutter_task_manager/popups/show_snackbar.dart';
import 'package:flutter_task_manager/popups/show_task_form.dart';
import 'package:flutter_task_manager/widgets/task_checkbox.dart';
import 'package:flutter_task_manager/widgets/task_deadline_text.dart';
import 'package:flutter_task_manager/popups/show_task_details.dart';
import '../models/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const TaskItem({
    super.key,
    required this.task,
    this.onToggle,
    this.onDelete,
    this.onEdit,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _expanded = false;

  void _toggleExpand() => setState(() => _expanded = !_expanded);

  Future<void> _toggleCheckbox() async {
    widget.task.completedAt = widget.task.isCompleted ? null : DateTime.now();
    await DatabaseHelper.instance.updateTask(widget.task);
    widget.onToggle?.call();
  }

  Future<void> _onDelete() async {
    _toggleExpand();
    final bool? confirmed = await showDeleteTaskConfirmation(
      context,
      widget.task,
    );
    if (confirmed == true) {
      await DatabaseHelper.instance.deleteTask(widget.task.id!);
      if (!mounted) return;
      showSnackbar(context, 'Pomyślnie usunięto zadanie');
      widget.onDelete?.call();
    }
  }

  void _onEdit() async {
    _toggleExpand();
    Task? task = await showTaskForm(context, widget.task);
    if (task != null) {
      await DatabaseHelper.instance.updateTask(task);
      if (mounted == true) {
        showSnackbar(context, 'Pomyślnie zaktualizowano zadanie.');
        widget.onEdit?.call();
      }
    }
  }

  void _onVisibilityTap() {
    _toggleExpand();
    showTaskDetailsDialog(context, widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _toggleExpand,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  spacing: 12,
                  children: [
                    TaskCheckbox(
                      completed: widget.task.isCompleted,
                      failure: widget.task.isOverdue,
                      onToggle: () => _toggleCheckbox(),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 2,
                        children: [
                          Text(
                            widget.task.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          TaskDeadlineText(task: widget.task),
                        ],
                      ),
                    ),
                  ],
                ),
                AnimatedSizeAndFade(
                  expanded: _expanded,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ActionIcon(
                          icon: Icons.visibility,
                          onTap: _onVisibilityTap,
                        ),
                        ActionIcon(icon: Icons.edit, onTap: _onEdit),
                        ActionIcon(
                          icon: Icons.delete,
                          color: Colors.redAccent,
                          onTap: _onDelete,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
