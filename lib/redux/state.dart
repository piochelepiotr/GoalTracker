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
}
