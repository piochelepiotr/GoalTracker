import 'package:flutter/material.dart';
import 'actions.dart';
import 'state.dart';
import '../model/goal.dart';
import '../model/task.dart';
import '../model/habit.dart';

int nextGoalID(List<Goal> goals) {
  return goals.fold(0, (m, goal) => goal.id > m ? goal.id : m) + 1;
}

int nextTaskID(List<Task> tasks) {
  return tasks.fold(0, (m, task) => task.id > m ? task.id : m) + 1;
}

int nextHabitID(List<Habit> habits) {
  return habits.fold(0, (m, habit) => habit.id > m ? habit.id : m) + 1;
}

AppState reducer(AppState prev, dynamic action) {
  if (action is DeleteGoal) {
    List<Goal> goals = List.from(prev.goals)
      ..removeWhere((goal) => goal.id == action.goalID);
    return prev.copyWith(goals: goals);
  }
  if (action is SelectGoal) {
    return prev.copyWith(selectedGoalID: action.goalID);
  }
  if (action is AddTask) {
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
  } else if (action is DeleteAction) {
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
    List<Habit> habits =
        goals.firstWhere((goal) => goal.id == prev.selectedGoalID).habits;
    habits.add(Habit(
        controller: TextEditingController(text: action.habit.name),
        name: action.habit.name,
        frequency: action.habit.frequency,
        times: action.habit.times,
        id: nextHabitID(habits)));
    return prev.copyWith(goals: goals);
  } else if (action is FocusAction) {
    return prev.updateFocus(action.index, null);
  } else if (action is FocusHabit) {
    return prev.updateFocus(null, action.index);
  }
  if (action is GoalsAction) {
    return prev.copyWith(
        goals: goalsReducer(prev.goals, action, prev.selectedGoalID));
  }
  print("unrecognized action type");
  return prev;
}

List<Goal> goalsReducer(List<Goal> prev, dynamic action, int selectedGoalID) {
  if (action is AddGoal) {
    List<Goal> goals = List<Goal>();
    bool newGoal = true;
    prev.forEach((goal) {
      if (goal.id == action.goal.id) {
        newGoal = false;
        goals.add(goalReducer(goal, action));
      } else {
        goals.add(goal);
      }
    });
    if (newGoal) {
      int id = nextGoalID(prev);
      goals.add(action.goal.copyWith(id: id));
    }
    return goals;
  }
  if (action is GoalAction) {
    return prev
        .map((goal) =>
            goal.id == selectedGoalID ? goalReducer(goal, action) : goal)
        .toList();
  }
  print("unrecognized action type");
  return prev;
}

Goal goalReducer(Goal prev, dynamic action) {
  if (action is AddGoal) {
    return prev.copyWith(
      name: action.goal.name,
      workUnit: action.goal.workUnit,
      workDone: action.goal.workDone,
      totalWork: action.goal.totalWork,
      color: action.goal.color,
    );
  }
  if (action is HabitsAction) {
    return prev.copyWith(
      habits: habitsReducer(prev.habits, action),
    );
  }
  if (action is ActionsAction) {
    return prev.copyWith(
      tasks: actionsReducer(prev.tasks, action),
    );
  }
  print("unrecognized action type");
  return prev;
}

List<Habit> habitsReducer(List<Habit> prev, dynamic action) {
  if (action is HabitAction) {
    return prev
        .map((habit) => habit.id == action.getHabit().id
            ? habitReducer(habit, action)
            : habit)
        .toList();
  }
  print("unrecognized action type");
  return prev;
}

Habit habitReducer(Habit prev, dynamic action) {
  if (action is EditHabit) {
    return action.habit;
  }
  print("unrecognized action type");
  return prev;
}

List<Task> actionsReducer(List<Task> prev, dynamic action) {
  if (action is ActionAction) {
    return prev
        .map((prevAction) => prevAction.id == action.getAction().id
            ? actionReducer(prevAction, action)
            : prevAction)
        .toList();
  }
  print("unrecognized action type");
  return prev;
}

Task actionReducer(Task prev, dynamic action) {
  if (action is CrossAction) {
    return prev.copyWith(
      crossed: !prev.crossed,
    );
  }
  print("unrecognized action type");
  return prev;
}
