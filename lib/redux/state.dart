class AppState {
  List<String> goals = List<String>();

  AppState({this.goals});

  AppState.fromAppState(AppState another) {
    goals = another.goals;
  }
}
