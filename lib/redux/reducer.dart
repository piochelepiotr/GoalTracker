import 'actions.dart';
import 'state.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is AddGoal) {
    return addGoal(state, action);
  }
  return state;
}

AppState addGoal(AppState state, AddGoal action) {
  return AppState(
      goals: List.from(state.goals)..add(action.goal),
  );
}
