import 'package:flutter/material.dart';

class ActionModel {
  final String name;
  final int id;
  final TextEditingController controller;
  bool crossed;
  ActionModel({this.name, this.id, this.crossed, this.controller}) {
    crossed ??= false;
  }

  factory ActionModel.fromJson(Map<String, dynamic> json) => new ActionModel(
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
      TextEditingController controller,
      bool crossed}) {
    return ActionModel(
      name: name ?? this.name,
      id: id ?? this.id,
      crossed: crossed ?? this.crossed,
      controller: controller ?? this.controller,
    );
  }
}
