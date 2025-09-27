import 'package:flutter_task_manager/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper instance = DatabaseHelper._init();
  static Database? _db;

  DatabaseHelper._init();

  Future<Database> get _database async {
    _db ??= await _openTaskManagerDB();
    return _db!;
  }

  Future<Database> _openTaskManagerDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'task_manager.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT, deadline INTEGER NOT NULL, completed_at INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }

  Future<Task> createTask(Task task) async {
    final Database db = await _database;
    final int id = await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return task.copyWith(id: id);
  }

  Future<List<Task>> allTasks() async {
    final db = await _database;
    final List<Map<String, Object?>> taskMaps = await db.query('tasks');
    return Task.fromMaps(taskMaps);
  }

  Future<int> updateTask(Task task) async {
    if (task.id == null) throw ArgumentError('Task ID cannot be null');
    final db = await _database;
    return db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await _database;
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
