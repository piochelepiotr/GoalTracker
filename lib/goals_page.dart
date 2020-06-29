import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'add_goal_page.dart';
import 'goal_page/goal_page.dart';
import 'redux/state.dart';
import 'model/goal.dart';
import 'redux/actions.dart';
import 'quote.dart';
import 'notifications/notifications.dart';
import 'components/bottom_bar.dart';
import 'analytics/analytics.dart';
import 'dart:ui';
import 'onboarding.dart';

class _Props {
  List<Goal> goals;
  Function(Goal) remove;
  Function(int oldIndex, int newIndex) reOrder;
  final bool addGoalIntroDone;
  _Props(
      {@required this.goals,
      @required this.remove,
      @required this.reOrder,
      @required this.addGoalIntroDone});
}

class GoalsPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GoalsPage> {
  GlobalKey _one = GlobalKey();

  @override
  void initState() {
    super.initState();
    initNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _Props>(
        converter: (store) => _Props(
          goals: store.state.goals,
          remove: (Goal goal) async {
            await removeGoalNotifications(goal);
            store.dispatch(DeleteGoal(goal.id));
          },
          reOrder: (int oldIndex, int newIndex) => {
            store.dispatch(ReOrderGoals(oldIndex, newIndex)),
          },
          addGoalIntroDone: store.state.addGoalIntroDone,
        ),
        builder: (context, props) {
          return Column(children: [
            Quote(),
            props.goals.length > 0
                ? Expanded(
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          // onReorder: (oldIndex, newIndex) {
                          //   print("reorder $oldIndex -> $newIndex");
                          //   props.reOrder(oldIndex, newIndex);
                          // },
                          children: [
                            for (final goal in props.goals)
                              Card(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                child: ListTile(
                                  title: Text(goal.name,
                                      style: TextStyle(color: goal.color)),
                                  subtitle: Text(goal.workString()),
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GoalPage(goalID: goal.id)),
                                    )
                                  },
                                  trailing: PopupMenuButton<String>(
                                    icon: Icon(Icons.more_vert),
                                    onSelected: (String selected) {
                                      if (selected == "delete") {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(goal.name),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(
                                                        "Are you sure you want to delete that goal?"),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                FlatButton(
                                                  child: Text('Cancel'),
                                                  onPressed:
                                                      Navigator.of(context).pop,
                                                ),
                                                FlatButton(
                                                  child: Text('Delete'),
                                                  onPressed: () {
                                                    sendAnalyticsEvent(
                                                        "deleteGoal");
                                                    props.remove(goal);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: "delete",
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        )))
                : Expanded(
                    child: Center(
                        child: Text("No Goals here yet",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withAlpha(180),
                                fontStyle: FontStyle.italic)))),
            BottomBar(buttons: [
              props.addGoalIntroDone
                  ? Button(
                      label: "Add Goal",
                      onPressed: () {
                        sendAnalyticsEvent("addGoalStart");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGoalPage()),
                        );
                      })
                  : OnBoardingWidget(
                      key: _one,
                      child: Button(
                          label: "Add Goal",
                          onPressed: () {
                            sendAnalyticsEvent("addGoalStartOnBoarding");
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddGoalPage()),
                            );
                          })),
            ]),
          ]);
        },
      ),
    );
  }
}
