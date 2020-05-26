import 'package:flutter/material.dart';

import '../model/goal.dart';
import '../model/task.dart';

class IncrWork {}

class DecrWork {}

class SetWork {
  final int workDone;
  SetWork(this.workDone);
}

class AddGoal {
  final Goal goal;
  AddGoal(this.goal);
}

class AddTask {
  final String taskName;
  AddTask(this.taskName);
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

class RemoveTask {
  final Task task;
  RemoveTask(this.task);
}

class CrossTask {
  final Task task;
  CrossTask(this.task);
}
