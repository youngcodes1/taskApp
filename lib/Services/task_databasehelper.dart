import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/task_model.dart';

class TaskDatabaseHelper {
  TaskDatabaseHelper.privateConstructor();
  static final TaskDatabaseHelper instance =
      TaskDatabaseHelper.privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, 'tasks.db');
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title STRING ,
            description TEXT ,
            category STRING ,
            createdDate STRING ,
            createdTime STRING,
            isCompleted INTEGER DEFAULT 0,
            color INTEGER 
          )
          ''');
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
    );
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  // Future<List<Map<String, dynamic>>> getAllTasks() async {
  //   final db = await database;
  //   return await db.query('tasks');
  // }

  Future<List<Task>> getTodaysTask() async {
    final db = await database;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'createdDate = ?',
      // whereArgs: [date],
      whereArgs: [today.toLocal().toString()],
    );
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id =?',
      whereArgs: [task.id],
    );
  }

  deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    getAllTasks();
  }
}
