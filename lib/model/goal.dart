import 'package:flutter/material.dart';

import 'task.dart';

Color stringToColor(String color) {
  print("parsing");
  print(color);
  var hexColor = color.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    print("it worked");
    return Color(int.parse("0x$hexColor"));
  }
}

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

  Goal(
      {this.name,
      this.id,
      this.tasks,
      this.workUnit,
      this.totalWork,
      this.workDone,
      this.color}) {
    tasks ??= List<Task>();
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
    List<Task> actionsList = actions();
    actionsList.forEach((task) {
      if (task.crossed) {
        done++;
      }
    });
    return "$done / ${actionsList.length} actions done";
  }

  factory Goal.fromJson(Map<String, dynamic> json) {
    List<Task> tasks = List<Task>();
    json['tasks']?.forEach((taskMap) => tasks.add(Task.fromJson(taskMap)));
    return Goal(
      id: json["id"],
      name: json["name"],
      tasks: tasks,
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
      "tasks": tasks.map((task) => task.toMap()).toList(),
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
      List<Task> tasks}) {
    return Goal(
      name: name ?? this.name,
      id: id ?? this.id,
      workUnit: workUnit ?? this.workUnit,
      totalWork: totalWork ?? this.totalWork,
      workDone: workDone ?? this.workDone,
      color: color ?? this.color,
      tasks: tasks ?? this.tasks,
    );
  }

  List<Task> actions() {
    List<Task> actions = List<Task>();
    tasks.forEach((task) => {
          if (task.habit == null || !task.habit) {actions.add(task)}
        });
    return actions;
  }

  List<Task> habits() {
    List<Task> habits = List<Task>();
    tasks.forEach((task) => {
          if (task.habit != null && task.habit == true) {habits.add(task)}
        });
    return habits;
  }
}
