import 'package:flutter/material.dart';
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
    List<Goal> goals = prev.goals.map((goal) {
      if (goal.id == prev.selectedGoalID) {
        bool newTask = true;
        List<Task> tasks = List<Task>();
        goal.tasks.forEach((task) {
          if (task.id == action.task.id) {
            newTask = false;
            tasks.add(task.copyWith(
              name: action.task.name,
            ));
          } else {
            tasks.add(task);
          }
        });
        if (newTask) {
          int id = nextTaskID(tasks);
          tasks.add(action.task.copyWith(id: id));
        }
        return goal.copyWith(tasks: tasks);
      } else {
        return goal;
      }
    }).toList();
    return prev.copyWith(goals: goals);
  } else if (action is RemoveTask) {
    List<Goal> goals = prev.goals.map((goal) {
      if (goal.id == prev.selectedGoalID) {
        List<Task> tasks = List.from(goal.tasks)
          ..removeWhere((task) => task.id == action.task.id);
        return goal.copyWith(tasks: tasks);
      } else {
        return goal;
      }
    }).toList();
    return prev.copyWith(goals: goals);
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
  } else if (action is SetWork) {
    List<Goal> goals = prev.goals.map((goal) {
      if (goal.id == prev.selectedGoalID) {
        return goal.copyWith(workDone: action.workDone);
      }
      return goal;
    }).toList();
    return prev.copyWith(goals: goals);
  } else if (action is AddHabit) {
    List<Goal> goals = List.from(prev.goals);
    List<Task> tasks =
        goals.firstWhere((goal) => goal.id == prev.selectedGoalID).tasks;
    tasks.add(Task(
        controller: TextEditingController(text: action.name),
        name: action.name,
        habit: true,
        frequency: action.frequency,
        times: action.times,
        id: nextTaskID(tasks)));
    return prev.copyWith(goals: goals);
  } else if (action is FocusAction) {
    return prev.updateFocus(action.index, null);
  } else if (action is FocusHabit) {
    return prev.updateFocus(null, action.index);
  }
  return prev;
}
