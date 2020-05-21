import '../model/goal.dart';

class AddGoal {
  final String goalName;
  AddGoal(this.goalName);
}

class LoadGoals {
  final List<Goal> goals;
  LoadGoals(this.goals);
}
