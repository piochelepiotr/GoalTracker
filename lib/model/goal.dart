import 'task.dart';

class Goal {
  final String name;
  final int id;
  List<Task> tasks;

  Goal({this.name, this.id}) {
    tasks = List<Task>();
  }

  factory Goal.fromMap(Map<String, dynamic> json) => new Goal(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
