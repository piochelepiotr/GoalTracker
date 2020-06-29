import 'dart:convert';

import '../model/goal.dart';

class AppState {
  List<Goal> goals = List<Goal>();
  final bool addGoalIntroDone;

  AppState({this.goals, this.addGoalIntroDone});

  AppState copyWith({List<Goal> goals, bool addGoalIntroDone}) {
    return AppState(
      goals: goals ?? this.goals,
      addGoalIntroDone: addGoalIntroDone ?? this.addGoalIntroDone,
    );
  }

  int nextGoalID() {
    return goals.fold(0, (m, goal) => goal.id > m ? goal.id : m) + 1;
  }

  Goal getGoal(int goalID) {
    return goals.firstWhere((goal) => goal.id == goalID);
  }

  static AppState fromJson(dynamic json) {
    List<Goal> goals = List<Goal>();
    if (json == null) {
      return AppState(goals: goals, addGoalIntroDone: false);
    }
    var jsonData = jsonDecode(json);
    jsonData['goals']?.forEach((goalMap) => goals.add(Goal.fromJson(goalMap)));
    print(jsonData['add_goal_intro_done']);
    return AppState(
      goals: goals,
      addGoalIntroDone: jsonData['add_goal_intro_done'] != null
          ? jsonData['add_goal_intro_done']
          : false,
    );
  }

  dynamic toJson() {
    dynamic json = jsonEncode({
      'goals': goals.map((goal) => goal.toMap()).toList(),
      'add_goal_intro_done': addGoalIntroDone,
    });
    return json;
  }
}
