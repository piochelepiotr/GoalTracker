import 'dart:convert';

import '../model/goal.dart';

class AppState {
  List<Goal> goals = List<Goal>();
  int selectedGoalID = 0;

  AppState({this.goals, this.selectedGoalID});

  AppState copyWith({List<Goal> goals, int selectedGoalID}) {
    return AppState(
      goals: goals ?? this.goals,
      selectedGoalID: selectedGoalID ?? this.selectedGoalID,
    );
  }

  static AppState fromJson(dynamic json) {
    var jsonData = jsonDecode(json);
    List<Goal> goals = List<Goal>();
    jsonData['goals'].forEach((goalMap) => goals.add(Goal.fromJson(goalMap)));
    return AppState(goals: goals);
  }

  dynamic toJson() {
    dynamic json =
        jsonEncode({'goals': goals.map((goal) => goal.toMap()).toList()});
    return json;
  }
}
