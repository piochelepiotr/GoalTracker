import 'dart:convert';

import '../model/goal.dart';

class AppState {
  List<Goal> goals = List<Goal>();
  final List<String> onBoardingDone;

  AppState({this.goals, this.onBoardingDone});

  AppState copyWith({List<Goal> goals, List<String> onBoardingDone}) {
    return AppState(
      goals: goals ?? this.goals,
      onBoardingDone: onBoardingDone ?? this.onBoardingDone,
    );
  }

  AppState doOnBoarding(String onBoarding) {
    return copyWith(
        onBoardingDone: List<String>.from(onBoardingDone)..add(onBoarding));
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
      return AppState(goals: goals, onBoardingDone: List<String>());
    }
    var jsonData = jsonDecode(json);
    jsonData['goals']?.forEach((goalMap) => goals.add(Goal.fromJson(goalMap)));
    List<String> onBoardingDone = List();
    // jsonData['onboarding_done']
    //     ?.forEach((onBoarding) => onBoardingDone.add(onBoarding));
    return AppState(
      goals: goals,
      onBoardingDone: onBoardingDone,
    );
  }

  dynamic toJson() {
    dynamic json = jsonEncode({
      'goals': goals.map((goal) => goal.toMap()).toList(),
      'onboarding_done': onBoardingDone,
    });
    return json;
  }
}
