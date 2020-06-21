import 'time.dart';

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

class Period {
  final String repr;
  final Duration duration;
  Period({this.repr, this.duration});
}

List<Period> periods = [
  // Period(repr: "5s", duration: Duration(seconds: 5)),
  // Period(repr: "5m", duration: Duration(minutes: 5)),
  Period(repr: "Day", duration: Duration(days: 1)),
  Period(repr: "Week", duration: Duration(days: 7)),
  Period(repr: "Month", duration: Duration(days: 30)),
  Period(repr: "Year", duration: Duration(days: 365))
];

String getPeriodRepr(Duration period) {
  return periods.firstWhere((p) => p.duration == period).repr;
}

Duration getPeriodDuration(String repr) {
  return periods.firstWhere((p) => p.repr == repr).duration;
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
  List<bool> notificationDays;
  bool notifications;
  List<int> notificationIDs;
  TimeInDay notificationTime;
  String workRemaining;
  Habit({
    this.name,
    this.id,
    this.period,
    this.objective,
    this.achieved = 0,
    this.habitHistory,
    this.start,
    this.notificationDays,
    this.notifications,
    this.notificationIDs,
    this.notificationTime,
    this.workRemaining,
  }) {
    // temp
    notificationTime ??= TimeInDay(hour: 19, minute: 0);
    notifications ??= false;
    //
    habitHistory ??= List<HabitResult>();
    start ??= DateTime.now();
    notificationDays ??= List<bool>.filled(7, true);
    notificationIDs ??= List<int>();
    remainingTime = getRemainingTime();
    workRemaining = getWorkRemaining(objective, achieved, remainingTime);
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
          start: start,
          length: period,
          objective: objective,
          achieved: achieved));
      achieved = 0;
      print("adding history");
      print(start);
      start = start.add(period);
    }
    return this.copyWith(
      achieved: achieved,
      habitHistory: habitHistory,
      start: start,
    );
  }

  int getAchievedHabits() {
    int ok = 0;
    habitHistory.forEach((result) {
      if (result.achieved == result.objective) {
        ok++;
      }
    });
    return ok;
  }

  int getLastStrike() {
    int strike = 0;
    for (int i = habitHistory.length - 1;
        i >= 0 && habitHistory[i].achieved == habitHistory[i].objective;
        strike++, i--) {}
    return strike;
  }

  int getLongestStrike() {
    int i = habitHistory.length - 1;
    int strike = 0;
    int longestStrike = 0;
    while (i >= 0) {
      while (i >= 0 && habitHistory[i].achieved == habitHistory[i].objective) {
        strike++;
        i--;
      }
      if (strike > longestStrike) {
        longestStrike = strike;
      }
      strike = 0;
      i--; // i is either -1, or current result is not achieved
    }
    return longestStrike;
  }

  String historySummary() {
    if (habitHistory.length == 0) {
      return "";
    }
    return "${getAchievedHabits()}/${habitHistory.length}";
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    List<HabitResult> habitHistory = List<HabitResult>();
    json['history']
        ?.forEach((result) => habitHistory.add(HabitResult.fromJson(result)));
    // List<int> notificationIDs = json['
    // json['notification_ids']?.forEach
    return Habit(
      id: json["id"],
      notifications: json["notifications"],
      notificationDays: List<bool>.from(json["notification_days"]),
      notificationTime: TimeInDay.fromJson(json["notification_time"]),
      name: json["name"],
      period: Duration(seconds: json["period"]),
      objective: json["objective"],
      achieved: json["achieved"],
      start: DateTime.fromMicrosecondsSinceEpoch(json["start"]),
      habitHistory: habitHistory,
      notificationIDs: List<int>.from(json["notification_ids"]),
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
        "notification_days": notificationDays,
        "notifications": notifications,
        "notification_time": notificationTime.toJson(),
        "notification_ids": notificationIDs,
      };

  Habit copyWith({
    DateTime start,
    String name,
    int id,
    Duration period,
    int objective,
    int achieved,
    List<HabitResult> habitHistory,
    bool notifications,
    List<int> notificationIDs,
    List<bool> notificationDays,
    TimeInDay notificationTime,
    String workRemaining,
  }) {
    Habit habit = Habit(
      start: start ?? this.start,
      name: name ?? this.name,
      id: id ?? this.id,
      period: period ?? this.period,
      objective: objective ?? this.objective,
      achieved: achieved ?? this.achieved,
      habitHistory: habitHistory ?? this.habitHistory,
      notifications: notifications ?? this.notifications,
      notificationIDs: notificationIDs ?? this.notificationIDs,
      notificationDays: notificationDays ?? this.notificationDays,
      notificationTime: notificationTime ?? this.notificationTime,
      workRemaining: workRemaining ?? this.workRemaining,
    );
    if (habit.shouldUpdate()) {
      habit = habit.updateHistory();
    }
    return habit;
  }
}

String getWorkRemaining(int objective, int achieved, String remainingTime) {
  int repetitionsLeft = objective - achieved;
  if (repetitionsLeft == 0) {
    return "Well done! Next time in $remainingTime";
  }
  return "$repetitionsLeft left to do in $remainingTime";
}
