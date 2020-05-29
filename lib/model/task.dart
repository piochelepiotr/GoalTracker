class Task {
  final String name;
  final int id;
  final bool habit;
  final String frequency;
  final int times;
  bool crossed;
  Task(
      {this.name,
      this.id,
      this.crossed,
      this.habit,
      this.frequency,
      this.times}) {
    crossed ??= false;
  }

  factory Task.fromJson(Map<String, dynamic> json) => new Task(
        id: json["id"],
        name: json["name"],
        crossed: json["crossed"],
        habit: json["habit"],
        frequency: json["frequency"],
        times: json["times"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "crossed": crossed,
        "habit": habit != null ? habit : false,
        "frequency": frequency != null ? frequency : "Day",
        "times": times != null ? times : 1,
      };

  copyWith(
      {String name,
      int id,
      bool habit,
      String frequency,
      int times,
      bool crossed}) {
    return Task(
      name: name ?? this.name,
      id: id ?? this.id,
      habit: habit ?? this.habit,
      frequency: frequency ?? this.frequency,
      times: times ?? this.times,
      crossed: crossed ?? this.crossed,
    );
  }
}
