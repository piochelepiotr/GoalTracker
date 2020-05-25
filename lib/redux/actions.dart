import 'package:flutter/material.dart';

import '../model/goal.dart';
import '../model/task.dart';

class AddGoal {
  final String goalName;
  final String workUnit;
  final int totalWork;
  final int workDone;
  final Color color;
  AddGoal(
      {this.goalName,
      this.workUnit,
      this.totalWork,
      this.workDone,
      this.color});
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
