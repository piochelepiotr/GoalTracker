import 'package:flutter/material.dart';

import 'task.dart';

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

  factory Goal.fromJson(Map<String, dynamic> json) {
    List<Task> tasks = List<Task>();
    json['tasks']?.forEach((taskMap) => tasks.add(Task.fromJson(taskMap)));
    return Goal(
      id: json["id"],
      name: json["name"],
      tasks: tasks,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "tasks": tasks.map((task) => task.toMap()).toList(),
        // "work_unit": workUnit,
        // "work_done": workDone,
        // "total_work": totalWork,
        // "color": color.value,
      };
}
