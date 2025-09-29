import 'package:flutter_task_manager/helpers/notification_helper.dart';
import 'package:flutter_task_manager/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _db;

  DatabaseHelper._init();

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'task_manager.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        deadline INTEGER NOT NULL,
        completed_at INTEGER
      )
    ''');
  }

  Future<int> createTask(Task task) async {
    final db = await database;
    int id = await db.insert('tasks', task.toMap());
    if (id > 0) {
      await NotificationHelper().scheduleTaskNotification(
        task.copyWith(id: id),
      );
    }
    return id;
  }

  Future<int> updateTask(Task task) async {
    if (task.id == null) throw ArgumentError('Task ID cannot be null');
    final db = await database;
    int id = await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    if (id > 0) {
      final updatedTask = task.copyWith(id: task.id);
      if (updatedTask.isCompleted) {
        await NotificationHelper().cancelTaskNotifications(task.id!);
      } else {
        await NotificationHelper().scheduleTaskNotification(updatedTask);
      }
    }
    return id;
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    int rows = await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    if (rows > 0) {
      await NotificationHelper().cancelTaskNotifications(id);
    }
    return rows;
  }

  Future<List<Task>> allTasks() async {
    final db = await database;
    final maps = await db.query('tasks', orderBy: 'deadline ASC');
    return Task.fromMaps(maps);
  }

  Future<List<Task>> ongoingTasks() async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final maps = await db.query(
      'tasks',
      where: 'completed_at IS NULL AND deadline >= ?',
      whereArgs: [now],
      orderBy: 'deadline ASC',
    );
    return Task.fromMaps(maps);
  }

  Future<List<Task>> completedTasks() async {
    final db = await database;
    final maps = await db.query(
      'tasks',
      where: 'completed_at IS NOT NULL',
      orderBy: 'completed_at DESC',
    );
    return Task.fromMaps(maps);
  }

  Future<List<Task>> overdueTasks() async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final maps = await db.query(
      'tasks',
      where: 'completed_at IS NULL AND deadline < ?',
      whereArgs: [now],
      orderBy: 'deadline ASC',
    );
    return Task.fromMaps(maps);
  }

  Future<List<Task>> tasksByType(TaskType type) {
    switch (type) {
      case TaskType.ongoing:
        return ongoingTasks();
      case TaskType.completed:
        return completedTasks();
      case TaskType.overdue:
        return overdueTasks();
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }
}
