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
import 'onboarding/first_screen.dart';
import 'onboarding/onboarding_pusher.dart';
import 'tips.dart';
import 'package:url_launcher/url_launcher.dart';

final email = "piotr.wolski42@gmail.com";

class _Props {
  List<Goal> goals;
  Function(Goal) remove;
  Function(int oldIndex, int newIndex) reOrder;
  final bool doneOnBoarding;
  final VoidCallback doOnBoarding;
  _Props({
    @required this.goals,
    @required this.remove,
    @required this.reOrder,
    @required this.doneOnBoarding,
    @required this.doOnBoarding,
  });
}

class GoalsPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GoalsPage> {
  @override
  void initState() {
    super.initState();
    initNotifications(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        StoreConnector<AppState, _Props>(
          converter: (store) => _Props(
            goals: store.state.goals,
            remove: (Goal goal) async {
              await removeGoalNotifications(goal);
              store.dispatch(DeleteGoal(goal.id));
            },
            reOrder: (int oldIndex, int newIndex) => {
              store.dispatch(ReOrderGoals(oldIndex, newIndex)),
            },
            doOnBoarding: () => store.dispatch(DoOnBoarding("add_goal")),
            doneOnBoarding: store.state.onBoardingDone.contains("add_goal"),
          ),
          builder: (context, props) {
            return Column(children: [
              OnBoardingPusher(
                  show: !props.doneOnBoarding,
                  onInit: () {
                    props.doOnBoarding();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstOnBoarding()),
                    );
                  }),
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
                                                        Navigator.of(context)
                                                            .pop,
                                                  ),
                                                  FlatButton(
                                                    child: Text('Delete'),
                                                    onPressed: () {
                                                      sendAnalyticsEvent(
                                                          "deleteGoal");
                                                      props.remove(goal);
                                                      Navigator.of(context)
                                                          .pop();
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
              Padding(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 15),
                  child: Row(children: [
                    RaisedButton(
                        color: Colors.white,
                        shape: CircleBorder(),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Tips()),
                          );
                        },
                        child: SizedBox(
                            width: 55,
                            height: 55,
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                            "images/big_icon.png")))))),
                    Spacer(),
                    Button(
                        label: "Add Goal",
                        onPressed: () {
                          sendAnalyticsEvent("addGoalStart");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddGoalPage()),
                          );
                        })
                  ])),
            ]);
          },
        ),
        Padding(
            padding: EdgeInsets.only(top: 30, right: 30),
            child: Row(children: [
              Spacer(),
              PopupMenuButton<String>(
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.black, // inkwell color
                        child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Icon(Icons.email, color: Colors.red)),
                      ),
                    ),
                  ),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: "help",
                          child: Text('Help'),
                        ),
                        const PopupMenuItem<String>(
                          value: "bug",
                          child: Text('Report bug'),
                        ),
                      ],
                  onSelected: (String selected) async {
                    String uri;
                    if (selected == "help") {
                      uri = 'mailto:$email?subject=Help}';
                    } else if (selected == "bug") {
                      uri = 'mailto:$email?subject=Bug}';
                    }
                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      print("No email client found");
                    }
                  })
            ])),
      ]),
    );
  }
}
