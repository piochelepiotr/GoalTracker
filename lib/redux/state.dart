import '../model/goal.dart';

class AppState {
  List<Goal> goals = List<Goal>();

  AppState({this.goals});

  AppState.fromAppState(AppState another) {
    goals = another.goals;
  }
}
