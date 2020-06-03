import '../model/goal.dart';
import '../model/task.dart';
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
  Task getAction();
}

class SetWork {
  final int workDone;
  SetWork(this.workDone);
}

class AddGoal extends GoalsAction {
  final Goal goal;
  AddGoal(this.goal);
}

class AddTask {
  final Task task;
  AddTask(this.task);
}

class AddHabit {
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

class DeleteAction {
  final Task task;
  DeleteAction(this.task);
}

class DeleteHabit {
  final Habit habit;
  DeleteHabit(this.habit);
}

class CrossAction extends ActionAction {
  final Task task;
  Task getAction() {
    return task;
  }

  CrossAction(this.task);
}

class FocusAction {
  final int index;
  FocusAction(this.index);
}

class FocusHabit {
  final int index;
  FocusHabit(this.index);
}
