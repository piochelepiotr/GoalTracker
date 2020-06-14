class TimeInDay {
  final int hour;
  final int minute;

  TimeInDay({
    this.hour = 0,
    this.minute = 0,
  });

  factory TimeInDay.fromJson(Map<String, dynamic> json) {
    return TimeInDay(
      hour: json["hour"],
      minute: json["minute"],
    );
  }

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "minute": minute,
      };
}
