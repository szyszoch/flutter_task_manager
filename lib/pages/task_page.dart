import 'package:flutter/material.dart';
import 'package:flutter_task_manager/models/task.dart';
import 'package:flutter_task_manager/helpers/database_helper.dart';
import 'package:flutter_task_manager/popups/show_task_form.dart';
import 'package:flutter_task_manager/task_item.dart';

class TaskPage extends StatefulWidget {
  final TaskType type;
  const TaskPage({super.key, required this.type});

  @override
  State<TaskPage> createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Task> _tasks = [];

  String get _emptyMessage {
    switch (widget.type) {
      case TaskType.ongoing:
        return 'Brak zadań w toku';
      case TaskType.completed:
        return 'Brak ukończonych zadań';
      case TaskType.overdue:
        return 'Brak zaległych zadań';
    }
  }

  Future<void> _loadTasks() async {
    final tasks = await _dbHelper.tasksByType(widget.type);
    if (!mounted) return;
    setState(() => _tasks = tasks);
  }

  Future<void> _refreshTasks() async {
    final tasks = await _dbHelper.tasksByType(widget.type);
    if (!mounted) return;

    final oldTasks = List<Task>.from(_tasks);
    for (var oldTask in oldTasks) {
      if (!tasks.any((t) => t.id == oldTask.id)) {
        _removeTask(oldTask);
      }
    }

    for (var newTask in tasks) {
      final existingIndex = _tasks.indexWhere((t) => t.id == newTask.id);
      if (existingIndex == -1) {
        _insertTask(newTask);
      } else {
        _tasks[existingIndex] = newTask;
      }
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> createTask() async {
    final newTask = await showTaskForm(context);
    if (newTask != null) {
      await _dbHelper.createTask(newTask);
      if (!mounted) return;
      _insertTask(newTask);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pomyślnie dodano zadanie.')),
      );
    }
  }

  void _insertTask(Task task) {
    _tasks.insert(0, task);
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 300),
    );
    if (!mounted) return;
    setState(() {});
  }

  void _removeTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index < 0) return;
    final removedTask = _tasks.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedTask, animation),
      duration: const Duration(milliseconds: 300),
    );
    if (_tasks.isNotEmpty) {
      setState(() {});
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  Widget _buildItem(Task task, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: TaskItem(
        task: task,
        onToggle: _refreshTasks,
        onDelete: () => _removeTask(task),
        onEdit: _refreshTasks,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshTasks,
        child: _tasks.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [Center(child: Text(_emptyMessage))],
              )
            : AnimatedList(
                key: _listKey,
                initialItemCount: _tasks.length,
                itemBuilder: (context, index, animation) =>
                    _buildItem(_tasks[index], animation),
              ),
      ),
    );
  }
}
