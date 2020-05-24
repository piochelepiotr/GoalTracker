import 'actions.dart';
import 'state.dart';
import '../model/goal.dart';
import '../model/task.dart';

int nextGoalID(List<Goal> goals) {
  return goals.fold(0, (m, goal) => goal.id > m ? goal.id : m) + 1;
}

int nextTaskID(List<Task> tasks) {
  return tasks.fold(0, (m, task) => task.id > m ? task.id : m) + 1;
}

AppState reducer(AppState prev, dynamic action) {
  if (action is AddGoal) {
    return prev.copyWith(
      goals: List.from(prev.goals)
        ..add(Goal(name: action.goalName, id: nextGoalID(prev.goals))),
    );
  } else if (action is RemoveGoal) {
    List<Goal> goals = List.from(prev.goals)
      ..removeWhere((goal) => goal.id == action.goalID);
    return prev.copyWith(goals: goals);
  } else if (action is SelectGoal) {
    return prev.copyWith(selectedGoalID: action.goalID);
  } else if (action is AddTask) {
    List<Goal> goals = List.from(prev.goals);
    List<Task> tasks =
        goals.firstWhere((goal) => goal.id == prev.selectedGoalID).tasks;
    tasks.add(Task(name: action.taskName, id: nextTaskID(tasks)));
    return prev.copyWith(goals: goals);
  } else if (action is RemoveTask) {
    List<Goal> goals = List.from(prev.goals);
    goals.firstWhere((goal) => goal.id == prev.selectedGoalID).tasks
      ..removeWhere((task) => task.id == action.task.id);
  } else if (action is CrossTask) {
    List<Goal> goals = List.from(prev.goals);
    Task task = goals
        .firstWhere((goal) => goal.id == prev.selectedGoalID)
        .tasks
        .firstWhere((task) => task.id == action.task.id);
    task.crossed = !task.crossed;
  }
  return prev;
}
