import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'goals_page.dart';
import 'redux/reducer.dart';
import 'redux/state.dart';

void main() {
  List<String> goals = List<String>();
  goals.add("Eat icecream");
  goals.add("Weight 200 pounds");
  goals.add("Fly");
  goals.add("Have a lion as a pet");
  goals.add("Run for 10 feet without shoes");
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
