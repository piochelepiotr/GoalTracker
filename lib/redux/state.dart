import 'dart:convert';

import '../model/goal.dart';

class AppState {
  List<Goal> goals = List<Goal>();
  int selectedGoalID = 0;
  int focusedAction;
  int focusedHabit;

  AppState(
      {this.goals, this.selectedGoalID, this.focusedAction, this.focusedHabit});

  AppState copyWith({List<Goal> goals, int selectedGoalID}) {
    return AppState(
      goals: goals ?? this.goals,
      selectedGoalID: selectedGoalID ?? this.selectedGoalID,
      focusedAction: this.focusedAction,
      focusedHabit: this.focusedHabit,
    );
  }

  // can't use method above to set focus to null
  AppState updateFocus(int focusedAction, int focusedHabit) {
    return AppState(
      goals: this.goals,
      selectedGoalID: this.selectedGoalID,
      focusedAction: focusedAction,
      focusedHabit: focusedHabit,
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
