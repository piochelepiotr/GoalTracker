class Task {
  final String name;
  final int id;
  final int goalID;
  Task({this.name, this.id, this.goalID});

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        name: json["name"],
        goalID: json["goal_id"],
      );
}
