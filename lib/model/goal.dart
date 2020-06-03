import 'package:flutter/material.dart';

import 'task.dart';
import 'habit.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class Goal {
  final String name;
  final int id;
  final String workUnit;
  final int totalWork;
  final int workDone;
  final Color color;
  List<Task> tasks;
  List<Habit> habits;

  Goal(
      {this.name,
      this.id,
      this.tasks,
      this.habits,
      this.workUnit,
      this.totalWork,
      this.workDone,
      this.color}) {
    tasks ??= List<Task>();
    habits ??= List<Habit>();
  }

  double progress() {
    if (totalWork == 0 || workDone > totalWork) {
      return 1;
    }
    return workDone / totalWork;
  }

  String workString() {
    return "$workDone / $totalWork $workUnit done";
  }

  String tasksDone() {
    int done = 0;
    tasks.forEach((task) {
      if (task.crossed) {
        done++;
      }
    });
    return "$done / ${tasks.length} actions done";
  }

  factory Goal.fromJson(Map<String, dynamic> json) {
    List<Task> tasks = List<Task>();
    json['actions']
        ?.forEach((actionMap) => tasks.add(Task.fromJson(actionMap)));

    List<Habit> habits = List<Habit>();
    json['habits']?.forEach((habitMap) => habits.add(Habit.fromJson(habitMap)));
    return Goal(
      id: json["id"],
      name: json["name"],
      tasks: tasks,
      habits: habits,
      workUnit: json["work_unit"],
      workDone: json["work_done"],
      totalWork: json["total_work"],
      color: HexColor.fromHex(json["color"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "actions": tasks.map((task) => task.toMap()).toList(),
      "habits": habits.map((habit) => habit.toMap()).toList(),
      "work_unit": workUnit,
      "work_done": workDone,
      "total_work": totalWork,
      "color": color.toHex(),
    };
  }

  Goal copyWith(
      {int id,
      String name,
      String workUnit,
      int totalWork,
      int workDone,
      Color color,
      List<Habit> habits,
      List<Task> tasks}) {
    return Goal(
      name: name ?? this.name,
      id: id ?? this.id,
      workUnit: workUnit ?? this.workUnit,
      totalWork: totalWork ?? this.totalWork,
      workDone: workDone ?? this.workDone,
      color: color ?? this.color,
      tasks: tasks ?? this.tasks,
      habits: habits ?? this.habits,
    );
  }
}
