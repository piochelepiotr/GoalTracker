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
          return db.execute(
              "CREATE TABLE goals(id INTEGER PRIMARY KEY, name TEXT)",
          );
        },
        version: 1,
    );
  }

  Future<void> newGoal(Goal goal) async {
    final db = await database;
    await db.insert(
        'goals',
        goal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteGoal(String goalName) async {
    final db = await database;
    await db.delete(
        'goals',
        where: 'name = ?',
        whereArgs: [goalName],
    );
  }

  Future<List<Goal>> goals() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('goals');
    return List.generate(maps.length, (i) {
      return Goal.fromMap(maps[i]);
    });
  }
}


