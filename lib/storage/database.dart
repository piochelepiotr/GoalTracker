import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/goal.dart';
import '../model/task.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_goals_database.db'),
      onCreate: (db, version) {
        Batch batch = db.batch();
        batch.execute("CREATE TABLE goals(id INTEGER PRIMARY KEY, name TEXT)");
        batch.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT, goal_id INTEGER)");
        return batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion == 1) {
          return db.execute(
              "CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT, goal_id INTEGER)");
        }
        return null;
      },
      version: 2,
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

  Future<void> deleteTask(int taskID) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskID],
    );
  }

  Future<List<Goal>> goals() async {
    final Database db = await database;
    final List<Map<String, dynamic>> goalsMaps = await db.query('goals');
    final List<Map<String, dynamic>> tasksMaps = await db.query('tasks');
    List<Goal> goals =
        goalsMaps.map((goalMap) => Goal.fromMap(goalMap)).toList();
    List<Task> tasks =
        tasksMaps.map((taskMap) => Task.fromMap(taskMap)).toList();
    tasks.forEach((task) =>
        goals.firstWhere((goal) => goal.id == task.goalID).tasks.add(task));
    return goals;
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
