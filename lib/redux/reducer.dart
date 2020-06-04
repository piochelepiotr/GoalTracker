import 'package:flutter/material.dart';
import 'actions.dart';
import 'state.dart';
import '../model/goal.dart';
import '../model/action.dart';
import '../model/habit.dart';

int nextGoalID(List<Goal> goals) {
  return goals.fold(0, (m, goal) => goal.id > m ? goal.id : m) + 1;
}

int nextActionID(List<ActionModel> actions) {
  return actions.fold(0, (m, action) => action.id > m ? action.id : m) + 1;
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
  if (action is IncrWork) {
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
      actions: actionsReducer(prev.actions, action),
    );
  }
  print("unrecognized action type");
  return prev;
}

List<Habit> habitsReducer(List<Habit> prev, dynamic action) {
  if (action is AddHabit) {
    return List.from(prev)
      ..add(action.habit.copyWith(
          controller: TextEditingController(text: action.habit.name),
          id: nextHabitID(prev)));
  }
  if (action is DeleteHabit) {
    return List.from(prev)..removeWhere((habit) => habit.id == action.habit.id);
  }
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

List<ActionModel> actionsReducer(List<ActionModel> prev, dynamic action) {
  if (action is AddAction) {
    return List.from(prev)
      ..add(action.action.copyWith(
          controller: TextEditingController(text: action.action.name),
          id: nextActionID(prev)));
  }
  if (action is DeleteAction) {
    return List.from(prev)
      ..removeWhere((prevAction) => prevAction.id == action.action.id);
  }
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

ActionModel actionReducer(ActionModel prev, dynamic action) {
  if (action is EditAction) {
    return action.action;
  }
  if (action is CrossAction) {
    return prev.copyWith(
      crossed: !prev.crossed,
    );
  }
  print("unrecognized action type");
  return prev;
}
