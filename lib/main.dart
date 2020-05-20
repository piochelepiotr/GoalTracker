import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'goals_page.dart';
import 'redux/reducer.dart';
import 'redux/state.dart';
import 'model/goal.dart';

void main() {
  List<Goal> goals = List<Goal>();
  goals.add(Goal(name:"Eat icecream"));
  goals.add(Goal(name:"Weight 200 pounds"));
  goals.add(Goal(name:"Fly"));
  goals.add(Goal(name:"Have a lion as a pet"));
  goals.add(Goal(name:"Run for 10 feet without shoes"));
  final store = new Store<AppState>(reducer, initialState: AppState(goals: goals));
  runApp(FlutterReduxApp(
    title: 'My Goals',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: title,
        home: GoalsPage(),
      ),
    );
  }
}
