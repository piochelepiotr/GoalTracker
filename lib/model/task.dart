import 'package:flutter/material.dart';

class Task {
  final String name;
  final int id;
  final TextEditingController controller;
  bool crossed;
  Task({this.name, this.id, this.crossed, this.controller}) {
    crossed ??= false;
  }

  factory Task.fromJson(Map<String, dynamic> json) => new Task(
        id: json["id"],
        name: json["name"],
        crossed: json["crossed"],
        controller: TextEditingController(text: json["name"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "crossed": crossed,
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
      crossed: crossed ?? this.crossed,
      controller: this.controller,
    );
  }
}
