import '../components/chart.dart';

class DayActivity {
  final DateTime day;
  final int activity;
  DayActivity({this.day, this.activity});
  DayActivity add(int x) {
    return DayActivity(day: this.day, activity: this.activity + x);
  }

  factory DayActivity.fromJson(Map<String, dynamic> json) => DayActivity(
        day: DateTime.fromMicrosecondsSinceEpoch(json["day"]),
        activity: json["activity"],
      );

  Map<String, dynamic> toJson() => {
        "day": day.microsecondsSinceEpoch,
        "activity": activity,
      };
}

class Activity {
  final List<DayActivity> dayActivities;
  Activity({this.dayActivities});

  factory Activity.fromJson(Map<String, dynamic> json) {
    List<DayActivity> activity = List<DayActivity>();
    if (json != null) {
      json['days']?.forEach(
          (dayActivity) => activity.add(DayActivity.fromJson(dayActivity)));
    }
    Activity a = Activity(
      dayActivities: activity,
    );
    return a;
  }

  Map<String, dynamic> toJson() => {
        "days": dayActivities.map((result) => result.toJson()).toList(),
      };

  Activity add(int x) {
    DateTime now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day);
    if (dayActivities.length == 0 ||
        dayActivities[dayActivities.length - 1].day.isBefore(day)) {
      return Activity(
          dayActivities: List<DayActivity>.from(dayActivities)
            ..add(DayActivity(day: day, activity: x)));
    }
    DayActivity last = dayActivities[dayActivities.length - 1].add(x);
    return Activity(
        dayActivities: dayActivities
          ..removeLast()
          ..add(last));
  }

  List<TimeSeries> getTimeSeries() {
    DateTime now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day);
    List<TimeSeries> activity = List<TimeSeries>();
    int j = dayActivities.length - 1;
    while (j >= 0 && activity.length < 7) {
      int value = 0;
      if (dayActivities[j].day.isAtSameMomentAs(day)) {
        value = dayActivities[j].activity;
        j--;
      }
      activity.insert(0, TimeSeries(day, value));
      day = day.subtract(Duration(days: 1));
    }
    return activity;
  }
}
