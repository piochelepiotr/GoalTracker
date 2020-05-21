import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import '../storage/database.dart';
import '../model/goal.dart';
import 'state.dart';
import 'actions.dart';

ThunkAction<AppState> getGoals = (Store<AppState> store) async {
  List<Goal> goals = await DBProvider.db.goals();
  store.dispatch(LoadGoals(goals));
};
