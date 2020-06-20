import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:appcenter/appcenter.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/foundation.dart' show TargetPlatform;

import 'goals_page.dart';
import 'redux/reducer.dart';
import 'redux/state.dart';
import 'model/goal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool ios = defaultTargetPlatform == TargetPlatform.iOS;
  String appSecret = ios
      ? "a8a33033-ef2f-4911-a664-a7d118287ce7"
      : "27330c2e-fe98-4161-83ef-c4a17fcfb029";

  await AppCenter.start(
      appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);

  var areAnalyticsEnabled = await AppCenterAnalytics.isEnabled;
  var areCrashesEnabled = await AppCenterCrashes.isEnabled;

  print("crashes $areCrashesEnabled");
  print("analytics $areAnalyticsEnabled");

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
