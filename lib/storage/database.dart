import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/goal.dart';



class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'my_goals_database.db'),
        onCreate: (db, version) {
          print("on create");
          return db.execute(
              //"CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT, goal_id INTEGER)",
              "CREATE TABLE goals(id INTEGER PRIMARY KEY, name TEXT)",
          );
        },
        version: 1,
    );
  }

  Future<int> newGoal(String goalName) async {
    final db = await database;
    return await db.insert(
        'goals',
        {"name": goalName},
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteGoal(int goalID) async {
    final db = await database;
    await db.delete(
        'goals',
        where: 'id = ?',
        whereArgs: [goalID],
    );
  }

  Future<List<Goal>> goals() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('goals');
    return List.generate(maps.length, (i) {
      return Goal.fromMap(maps[i]);
    });
  }

  Future<int> addTask(int goalID, String taskName) async {
    final db = await database;
    return await db.insert(
        'tasks',
        {"name": taskName, "goal_id": goalID},
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}


