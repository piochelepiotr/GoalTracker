import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'goals_page.dart';
import 'redux/reducer.dart';
import 'redux/state.dart';
import 'model/goal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );
  final initialState = await persistor.load();
  final store = new Store<AppState>(
    reducer,
    initialState: initialState ?? AppState(goals: List<Goal>()),
    middleware: [persistor.createMiddleware()],
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
      child: MaterialApp(
        title: title,
        home: GoalsPage(),
      ),
    );
  }
}
