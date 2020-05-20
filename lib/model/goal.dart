class Goal {
  final String name;
  final int id;

  Goal({this.name, this.id});

  factory Goal.fromMap(Map<String, dynamic> json) => new Goal(
      id: json["id"],
      name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
