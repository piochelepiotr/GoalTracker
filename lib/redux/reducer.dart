import 'actions.dart';
import 'state.dart';
import '../model/goal.dart';

AppState reducer(AppState prev, dynamic action) {
  if (action is AddGoal) {
    Goal goal = Goal(name:action.goalName);
    return AppState(
        goals: List.from(prev.goals)..add(goal),
    );
  } else if (action is LoadGoals) {
    return AppState(goals:action.goals);
  } else if (action is RemoveGoal) {
    List<Goal> goals = List.from(prev.goals)..removeWhere((goal) => goal.name == action.goalName);
    return AppState(goals: goals);
  }
  return prev;
}
