String formatDuration(Duration d) {
  if (d < Duration(minutes: 1)) {
    return d.inSeconds.toString() + " seconds";
  }
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
        length: Duration(seconds: json["period"]),
        achieved: json["achieved"],
        objective: json["objective"],
      );

  Map<String, dynamic> toJson() => {
        "start": start.microsecondsSinceEpoch,
        "period": length.inSeconds,
        "achieved": achieved,
        "objective": objective,
      };
}

class Habit {
  final String name;
  final int id;
  final Duration period;
  String remainingTime;
  final int objective;
  final int achieved;
  DateTime start;
  List<HabitResult> habitHistory;
  Habit(
      {this.name,
      this.id,
      this.period,
      this.objective,
      this.achieved = 0,
      this.habitHistory,
      this.start}) {
    habitHistory ??= List<HabitResult>();
    start ??= DateTime.now();
    remainingTime = getRemainingTime();
  }

  String getRemainingTime() {
    return formatDuration(start.add(period).difference(DateTime.now()));
  }

  bool shouldUpdate() {
    return start.add(period).isBefore(DateTime.now()) ||
        getRemainingTime() != remainingTime;
  }

  // updateHistory shifts the list of achieved / failed goals based on current time. It returns a new habit
  Habit updateHistory() {
    int achieved = this.achieved;
    List<HabitResult> habitHistory = List<HabitResult>.from(this.habitHistory);
    DateTime start = this.start;
    DateTime now = DateTime.now();
    while (start.add(period).isBefore(now)) {
      habitHistory.add(HabitResult(
          length: period, objective: objective, achieved: achieved));
      achieved = 0;
      start = start.add(period);
    }
    return this.copyWith(
      achieved: achieved,
      habitHistory: habitHistory,
      start: start,
    );
  }

  String workRemaining() {
    int repetitionsLeft = objective - achieved;
    if (repetitionsLeft == 0) {
      return "Well done! Next time in $remainingTime";
    }
    return "$repetitionsLeft left to do in $remainingTime";
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    List<HabitResult> habitHistory = List<HabitResult>();
    json['history']
        ?.forEach((result) => habitHistory.add(HabitResult.fromJson(result)));
    return Habit(
      id: json["id"],
      name: json["name"],
      period: Duration(seconds: json["period"]),
      objective: json["objective"],
      achieved: json["achieved"],
      start: DateTime.fromMicrosecondsSinceEpoch(json["start"]),
      habitHistory: habitHistory,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "period": period.inSeconds,
        "objective": objective,
        "achieved": achieved,
        "history": habitHistory.map((result) => result.toJson()).toList(),
        "start": start.microsecondsSinceEpoch,
      };

  Habit copyWith({
    DateTime start,
    String name,
    int id,
    Duration period,
    int objective,
    int achieved,
    List<HabitResult> habitHistory,
  }) {
    return Habit(
      start: start ?? this.start,
      name: name ?? this.name,
      id: id ?? this.id,
      period: period ?? this.period,
      objective: objective ?? this.objective,
      achieved: achieved ?? this.achieved,
      habitHistory: habitHistory ?? this.habitHistory,
    );
  }
}
