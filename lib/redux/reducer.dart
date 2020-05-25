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
    List<Goal> goals = List<Goal>();
    bool newGoal = true;
    prev.goals.forEach((goal) {
      if (goal.id == action.goal.id) {
        newGoal = false;
        goals.add(goal.copyWith(
          name: action.goal.name,
          workUnit: action.goal.workUnit,
          workDone: action.goal.workDone,
          totalWork: action.goal.totalWork,
          color: action.goal.color,
        ));
      } else {
        goals.add(goal);
      }
    });
    if (newGoal) {
      int id = nextGoalID(prev.goals);
      goals.add(action.goal.copyWith(id: id));
    }
    return prev.copyWith(
      goals: List.from(goals),
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
  } else if (action is IncrWork) {
    List<Goal> goals = prev.goals.map((goal) {
      if (goal.id == prev.selectedGoalID) {
        if (goal.workDone < goal.totalWork) {
          return goal.copyWith(workDone: goal.workDone + 1);
        }
      }
      return goal;
    }).toList();
    return prev.copyWith(goals: goals);
  } else if (action is DecrWork) {
    List<Goal> goals = prev.goals.map((goal) {
      if (goal.id == prev.selectedGoalID) {
        if (goal.workDone > 0) {
          return goal.copyWith(workDone: goal.workDone - 1);
        }
      }
      return goal;
    }).toList();
    return prev.copyWith(goals: goals);
  }
  return prev;
}
