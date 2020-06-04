import 'package:flutter/material.dart';

class HabitResult {
  DateTime start;
  Duration length;
  int objective;
  int achieved;
}

class Habit {
  final String name;
  final int id;
  final String frequency;
  final int times;
  final TextEditingController controller;
  List<HabitResult> habitsHistory;
  Habit({this.name, this.id, this.frequency, this.times, this.controller});

  factory Habit.fromJson(Map<String, dynamic> json) => new Habit(
        id: json["id"],
        name: json["name"],
        frequency: json["frequency"],
        times: json["times"],
        controller: TextEditingController(text: json["name"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "frequency": frequency != null ? frequency : "Day",
        "times": times != null ? times : 1,
      };

  copyWith({
    String name,
    int id,
    String frequency,
    int times,
    TextEditingController controller,
  }) {
    return Habit(
      name: name ?? this.name,
      id: id ?? this.id,
      frequency: frequency ?? this.frequency,
      times: times ?? this.times,
      controller: controller ?? this.controller,
    );
  }
}
