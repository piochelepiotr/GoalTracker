import '../model/goal.dart';
import '../model/action.dart';
import '../model/habit.dart';

class IncrWork {
  final int goalID;
  IncrWork(this.goalID);
}

class DecrWork {
  final int goalID;
  DecrWork(this.goalID);
}

abstract class GoalsAction {}

abstract class GoalAction extends GoalsAction {
  int getGoalID();
}

abstract class HabitsAction extends GoalAction {}

abstract class HabitAction extends HabitsAction {
  Habit getHabit();
}

abstract class ActionsAction extends GoalAction {}

abstract class ActionAction extends ActionsAction {
  ActionModel getAction();
}

class SetWork {
  final int workDone;
  final int goalID;
  SetWork(this.workDone, this.goalID);
}

class AddGoal extends GoalsAction {
  final Goal goal;
  AddGoal(this.goal);
}

class AddAction extends ActionsAction {
  final int goalID;
  final ActionModel action;
  int getGoalID() {
    return goalID;
  }

  AddAction(this.action, this.goalID);
}

class EditAction extends ActionAction {
  final int goalID;
  final ActionModel action;
  ActionModel getAction() {
    return action;
  }

  int getGoalID() {
    return goalID;
  }

  EditAction(this.action, this.goalID);
}

class AddHabit extends HabitsAction {
  final int goalID;
  final Habit habit;
  int getGoalID() {
    return goalID;
  }

  AddHabit(this.habit, this.goalID);
}

class EditHabit extends HabitAction {
  final int goalID;
  final Habit habit;
  int getGoalID() {
    return goalID;
  }

  Habit getHabit() {
    return habit;
  }

  EditHabit(this.habit, this.goalID);
}

class DeleteGoal {
  final int goalID;
  DeleteGoal(this.goalID);
}

class DeleteAction extends ActionsAction {
  final int goalID;
  final ActionModel action;
  int getGoalID() {
    return goalID;
  }

  DeleteAction(this.action, this.goalID);
}

class DeleteHabit extends HabitsAction {
  final int goalID;
  final Habit habit;
  int getGoalID() {
    return goalID;
  }

  DeleteHabit(this.habit, this.goalID);
}

class CrossAction extends ActionAction {
  final int goalID;
  final ActionModel action;
  int getGoalID() {
    return goalID;
  }

  ActionModel getAction() {
    return action;
  }

  CrossAction(this.action, this.goalID);
}

class ReOrderHabits extends HabitsAction {
  final int goalID;
  final int oldIndex;
  final int newIndex;
  int getGoalID() {
    return goalID;
  }

  ReOrderHabits(this.oldIndex, this.newIndex, this.goalID);
}

class ReOrderActions extends ActionsAction {
  final int goalID;
  final int oldIndex;
  final int newIndex;
  int getGoalID() {
    return goalID;
  }

  ReOrderActions(this.oldIndex, this.newIndex, this.goalID);
}

class ReOrderGoals extends GoalsAction {
  final int oldIndex;
  final int newIndex;
  ReOrderGoals(this.oldIndex, this.newIndex);
}

class IncrHabitAchieved extends HabitAction {
  final int goalID;
  final Habit habit;
  int getGoalID() {
    return goalID;
  }

  IncrHabitAchieved(this.habit, this.goalID);
  Habit getHabit() {
    return habit;
  }
}

class DecrHabitAchieved extends HabitAction {
  final int goalID;
  final Habit habit;
  int getGoalID() {
    return goalID;
  }

  DecrHabitAchieved(this.habit, this.goalID);
  Habit getHabit() {
    return habit;
  }
}
