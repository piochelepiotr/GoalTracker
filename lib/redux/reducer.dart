import 'actions.dart';
import 'state.dart';
import '../model/goal.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is AddGoal) {
    return addGoal(state, action);
  }
  return state;
}

AppState addGoal(AppState state, AddGoal action) {
  Goal goal = Goal(name:action.goalName);
  return AppState(
      goals: List.from(state.goals)..add(goal),
  );
}
