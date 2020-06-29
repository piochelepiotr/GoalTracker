import 'package:flutter/material.dart';
import 'actions.dart';
import 'state.dart';
import '../model/goal.dart';
import '../model/action.dart';
import '../model/habit.dart';

int nextActionID(List<ActionModel> actions) {
  return actions.fold(0, (m, action) => action.id > m ? action.id : m) + 1;
}

int nextHabitID(List<Habit> habits) {
  return habits.fold(0, (m, habit) => habit.id > m ? habit.id : m) + 1;
}

AppState reducer(AppState prev, dynamic action) {
  if (action is AddGoal && !prev.addGoalIntroDone) {
    prev = prev.copyWith(addGoalIntroDone: true);
  }
  if (action is DeleteGoal) {
    List<Goal> goals = List.from(prev.goals)
      ..removeWhere((goal) => goal.id == action.goalID);
    return prev.copyWith(goals: goals);
  }
  if (action is IncrWork) {
    List<Goal> goals = prev.goals.map((goal) {
      if (goal.id == action.goalID) {
        if (goal.workDone < goal.totalWork) {
          return goal.copyWith(workDone: goal.workDone + 1);
        }
      }
      return goal;
    }).toList();
    return prev.copyWith(goals: goals);
  } else if (action is DecrWork) {
    List<Goal> goals = prev.goals.map((goal) {
      if (goal.id == action.goalID) {
        if (goal.workDone > 0) {
          return goal.copyWith(workDone: goal.workDone - 1);
        }
      }
      return goal;
    }).toList();
    return prev.copyWith(goals: goals);
  } else if (action is SetWork) {
    List<Goal> goals = prev.goals.map((goal) {
      if (goal.id == action.goalID) {
        return goal.copyWith(workDone: action.workDone);
      }
      return goal;
    }).toList();
    return prev.copyWith(goals: goals);
  }
  if (action is GoalsAction) {
    return prev.copyWith(goals: goalsReducer(prev.goals, action));
  }
  print("unrecognized action type");
  return prev;
}

List<Goal> goalsReducer(List<Goal> prev, dynamic action) {
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
      goals.add(action.goal);
    }
    return goals;
  }
  if (action is ReOrderGoals) {
    int oldIndex = action.oldIndex;
    List<Goal> goals = List.from(prev);
    Goal goal = goals[oldIndex];
    goals.insert(action.newIndex, goal);
    if (action.newIndex < oldIndex) {
      oldIndex++;
    }
    goals.removeAt(oldIndex);
    return goals;
  }
  if (action is GoalAction) {
    return prev
        .map((goal) =>
            goal.id == action.getGoalID() ? goalReducer(goal, action) : goal)
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
    return List.from(prev)..add(action.habit.copyWith(id: nextHabitID(prev)));
  }
  if (action is DeleteHabit) {
    return List.from(prev)..removeWhere((habit) => habit.id == action.habit.id);
  }
  if (action is ReOrderHabits) {
    int oldIndex = action.oldIndex;
    List<Habit> habits = List.from(prev);
    Habit habit = habits[oldIndex];
    habits.insert(action.newIndex, habit);
    if (action.newIndex < oldIndex) {
      oldIndex++;
    }
    habits.removeAt(oldIndex);
    return habits;
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
  if (action is IncrHabitAchieved) {
    int achieved = prev.achieved;
    if (prev.achieved < prev.objective) {
      achieved++;
    }
    return prev.copyWith(achieved: achieved);
  }
  if (action is DecrHabitAchieved) {
    int achieved = prev.achieved;
    if (prev.achieved > 0) {
      achieved--;
    }
    return prev.copyWith(achieved: achieved);
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
  if (action is ReOrderActions) {
    int oldIndex = action.oldIndex;
    List<ActionModel> actions = List.from(prev);
    actions.insert(action.newIndex, actions[oldIndex]);
    if (action.newIndex < oldIndex) {
      oldIndex++;
    }
    actions.removeAt(oldIndex);
    return actions;
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
