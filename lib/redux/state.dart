import 'dart:convert';

import '../model/goal.dart';

class AppState {
  List<Goal> goals = List<Goal>();
  int focusedAction;

  AppState({this.goals, this.focusedAction});

  AppState copyWith({List<Goal> goals, int selectedGoalID}) {
    return AppState(
      goals: goals ?? this.goals,
      focusedAction: this.focusedAction,
    );
  }

  // can't use method above to set focus to null
  AppState updateFocus(int focusedAction) {
    return AppState(
      goals: this.goals,
      focusedAction: focusedAction,
    );
  }

  Goal getGoal(int goalID) {
    return goals.firstWhere((goal) => goal.id == goalID);
  }

  static AppState fromJson(dynamic json) {
    List<Goal> goals = List<Goal>();
    if (json == null) {
      return AppState(goals: goals);
    }
    var jsonData = jsonDecode(json);
    jsonData['goals']?.forEach((goalMap) => goals.add(Goal.fromJson(goalMap)));
    return AppState(goals: goals);
  }

  dynamic toJson() {
    dynamic json =
        jsonEncode({'goals': goals.map((goal) => goal.toMap()).toList()});
    return json;
  }
}
