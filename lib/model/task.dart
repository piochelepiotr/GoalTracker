class Task {
  final String name;
  final int id;
  bool crossed;
  Task({this.name, this.id, this.crossed}) {
    crossed ??= false;
  }

  factory Task.fromJson(Map<String, dynamic> json) => new Task(
        id: json["id"],
        name: json["name"],
        crossed: json["crossed"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "crossed": crossed,
      };
}
