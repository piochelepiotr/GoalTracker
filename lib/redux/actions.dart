import '../model/goal.dart';
import '../model/task.dart';

class AddGoalDone {
  final Goal goal;
  AddGoalDone(this.goal);
}

class AddTaskDone {
  final Task task;
  AddTaskDone(this.task);
}

class LoadGoals {
  final List<Goal> goals;
  LoadGoals(this.goals);
}

class RemoveGoal {
  final int goalID;
  RemoveGoal(this.goalID);
}

class SelectGoal {
  final int goalID;
  SelectGoal(this.goalID);
}
