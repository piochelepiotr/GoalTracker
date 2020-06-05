import 'dart:convert';

import '../model/goal.dart';

class AppState {
  List<Goal> goals = List<Goal>();
  int selectedGoalID = 0;
  int focusedAction;

  AppState({this.goals, this.selectedGoalID, this.focusedAction});

  AppState copyWith({List<Goal> goals, int selectedGoalID}) {
    return AppState(
      goals: goals ?? this.goals,
      selectedGoalID: selectedGoalID ?? this.selectedGoalID,
      focusedAction: this.focusedAction,
    );
  }

  // can't use method above to set focus to null
  AppState updateFocus(int focusedAction, int focusedHabit) {
    return AppState(
      goals: this.goals,
      selectedGoalID: this.selectedGoalID,
      focusedAction: focusedAction,
    );
  }

  Goal activeGoal() {
    return goals.firstWhere((goal) => goal.id == selectedGoalID);
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
