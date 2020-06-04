import 'package:flutter/material.dart';

String formatDuration(Duration d) {
  if (d < Duration(hours: 1)) {
    return d.inMinutes.toString() + " minutes";
  }
  if (d < Duration(days: 1)) {
    return d.inHours.toString() + " hours";
  }
  if (d < Duration(days: 7)) {
    return d.inDays.toString() + " days";
  }
  if (d < Duration(days: 30)) {
    return (d.inDays ~/ 7).toString() + " weeks";
  }
  if (d < Duration(days: 365)) {
    return (d.inDays ~/ 30).toString() + " months";
  }
  return " a lot of time";
}

class HabitResult {
  DateTime start;
  Duration length;
  int objective;
  int achieved;
  HabitResult({this.start, this.length, this.objective, this.achieved}) {
    start ??= DateTime.now();
    achieved ??= 0;
  }

  factory HabitResult.fromJson(Map<String, dynamic> json) => new HabitResult(
        start: DateTime.fromMicrosecondsSinceEpoch(json["start"]),
        length: Duration(minutes: json["period"]),
        achieved: json["achieved"],
        objective: json["objective"],
      );

  Map<String, dynamic> toJson() => {
        "start": start.microsecondsSinceEpoch,
        "period": length.inMinutes,
        "achieved": achieved,
        "objective": objective,
      };
}

class Habit {
  final String name;
  final int id;
  final Duration frequency;
  final int times;
  final TextEditingController controller;
  List<HabitResult> habitHistory;
  Habit(
      {this.name,
      this.id,
      this.frequency,
      this.times,
      this.controller,
      this.habitHistory}) {
    habitHistory ??= List<HabitResult>();
    updateHistory();
    DateTime now = DateTime.now();
    print("habit was created that many minutes ago");
    print(now.difference(habitHistory.last.start).inMinutes);
  }

  // updateHistory shifts the list of achieved / failed goals based on current time
  void updateHistory() {
    if (habitHistory.length == 0) {
      habitHistory.add(HabitResult(length: frequency, objective: times));
    }
  }

  String workRemaining() {
    HabitResult current = habitHistory.last;
    String timeLeft =
        formatDuration(current.start.add(frequency).difference(DateTime.now()));
    int repetitionsLeft = times - current.achieved;
    return "$repetitionsLeft left to do in $timeLeft";
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    List<HabitResult> habitHistory = List<HabitResult>();
    json['history']
        ?.forEach((result) => habitHistory.add(HabitResult.fromJson(result)));
    return Habit(
      id: json["id"],
      name: json["name"],
      frequency: Duration(minutes: json["frequency"]),
      times: json["times"],
      controller: TextEditingController(text: json["name"]),
      habitHistory: habitHistory,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "frequency": frequency.inMinutes,
        "times": times,
        "history": habitHistory.map((result) => result.toJson()).toList(),
      };

  copyWith({
    String name,
    int id,
    Duration frequency,
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
