import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'goals_page.dart';
import 'redux/reducer.dart';
import 'redux/state.dart';
import 'model/goal.dart';
import 'redux/thunk.dart';

void main() async {
  final store = new Store<AppState>(
    reducer,
    initialState: AppState(goals: List<Goal>()),
    middleware: [thunkMiddleware],
  );
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
      child: new StoreConnector<AppState, VoidCallback>(converter: (store) {
        return () => {};
      }, builder: (context, callback) {
        return MaterialApp(
          title: title,
          home: GoalsPage(),
        );
      }, onInit: (store) {
        store.dispatch(getGoals);
      }),
    );
  }
}
