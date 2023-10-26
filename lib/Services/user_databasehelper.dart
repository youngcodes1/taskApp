import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

import '../Models/user_model.dart';

class UserDatabaseHelper {
  UserDatabaseHelper.privateConstructor();
  static final UserDatabaseHelper instance =
      UserDatabaseHelper.privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, 'users.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
          ''');
  }

  createUser(User user) async {
    final db = await database;
    return await db.insert('users', user.tomap());
  }

  Future<User?> queryUser(String email, String password) async {
    final db = await database;
    final users = await db.query(
      'users',
      where: 'email =? AND password=?',
      whereArgs: [email, password],
    );
    if (users.isNotEmpty) {
      return User.fromMap(users.first);
    }
    return null;
  }
}
