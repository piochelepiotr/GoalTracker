import 'actions.dart';
import 'state.dart';
import '../model/goal.dart';

AppState reducer(AppState prev, dynamic action) {
  if (action is AddGoalDone) {
    return prev.copyWith(
        goals: List.from(prev.goals)..add(action.goal),
    );
  } else if (action is LoadGoals) {
    return prev.copyWith(goals:action.goals);
  } else if (action is RemoveGoal) {
    List<Goal> goals = List.from(prev.goals)..removeWhere((goal) => goal.id == action.goalID);
    return prev.copyWith(goals: goals);
  } else if (action is SelectGoal) {
    return prev.copyWith(selectedGoalID: action.goalID);
  }
  return prev;
}
