import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import '../storage/database.dart';
import '../model/goal.dart';
import '../model/task.dart';
import 'state.dart';
import 'actions.dart';

ThunkAction<AppState> getGoals = (Store<AppState> store) async {
  List<Goal> goals = await DBProvider.db.goals();
  store.dispatch(LoadGoals(goals));
};

ThunkAction<AppState> addGoal(String goalName) {
  return (Store<AppState> store) async {
    int id = await DBProvider.db.newGoal(goalName);
    Goal goal = Goal(name: goalName, id:id);
    store.dispatch(AddGoalDone(goal));
  };
}

ThunkAction<AppState> addTask(int goalID, String taskName) {
  return (Store<AppState> store) async {
    int id = await DBProvider.db.addTask(goalID, taskName);
    Task task = Task(name: taskName, id:id, goalID: goalID);
    store.dispatch(AddTaskDone(task));
  };
}
