import '../model/goal.dart';
import '../model/action.dart';
import '../model/habit.dart';

class IncrWork {}

class DecrWork {}

abstract class GoalsAction {}

abstract class GoalAction extends GoalsAction {}

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
  SetWork(this.workDone);
}

class AddGoal extends GoalsAction {
  final Goal goal;
  AddGoal(this.goal);
}

class AddAction extends ActionsAction {
  final ActionModel action;
  AddAction(this.action);
}

class EditAction extends ActionAction {
  final ActionModel action;
  ActionModel getAction() {
    return action;
  }

  EditAction(this.action);
}

class AddHabit extends HabitsAction {
  final Habit habit;
  AddHabit(this.habit);
}

class EditHabit extends HabitAction {
  final Habit habit;
  Habit getHabit() {
    return habit;
  }

  EditHabit(this.habit);
}

class DeleteGoal {
  final int goalID;
  DeleteGoal(this.goalID);
}

class SelectGoal {
  final int goalID;
  SelectGoal(this.goalID);
}

class DeleteAction extends ActionsAction {
  final ActionModel action;
  DeleteAction(this.action);
}

class DeleteHabit extends HabitsAction {
  final Habit habit;
  DeleteHabit(this.habit);
}

class CrossAction extends ActionAction {
  final ActionModel action;
  ActionModel getAction() {
    return action;
  }

  CrossAction(this.action);
}

class FocusAction {
  final int index;
  FocusAction(this.index);
}

class ReOrderHabits extends HabitsAction {
  final int oldIndex;
  final int newIndex;
  ReOrderHabits(this.oldIndex, this.newIndex);
}

class ReOrderActions extends ActionsAction {
  final int oldIndex;
  final int newIndex;
  ReOrderActions(this.oldIndex, this.newIndex);
}

class ReOrderGoals extends GoalsAction {
  final int oldIndex;
  final int newIndex;
  ReOrderGoals(this.oldIndex, this.newIndex);
}

class IncrHabitAchieved extends HabitAction {
  final Habit habit;
  IncrHabitAchieved(this.habit);
  Habit getHabit() {
    return habit;
  }
}

class DecrHabitAchieved extends HabitAction {
  final Habit habit;
  DecrHabitAchieved(this.habit);
  Habit getHabit() {
    return habit;
  }
}
