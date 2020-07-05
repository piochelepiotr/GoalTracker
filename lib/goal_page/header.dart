import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/state.dart';
import '../redux/actions.dart';
import '../model/goal.dart';
import '../notifications/notifications.dart';
import '../add_goal_page.dart';

typedef void _SetWork(int workDone);

class _Props {
  Goal goal;
  VoidCallback incrWork;
  VoidCallback decrWork;
  _SetWork setWork;
  _Props({
    this.goal,
    this.incrWork,
    this.decrWork,
    this.setWork,
  });
}

class GoalPageHeader extends StatelessWidget {
  final int goalID;

  GoalPageHeader({@required this.goalID});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Props>(
      converter: (store) => _Props(
        goal: store.state.getGoal(goalID),
        incrWork: () {
          final Goal goal = store.state.getGoal(goalID);
          if (goal.workDone >= goal.totalWork) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                    "To increase the total work for this goal, click on the edit icon in the top right corner")));
          } else {
            store.dispatch(IncrWork(goalID));
          }
        },
        decrWork: () {
          store.dispatch(DecrWork(goalID));
        },
        setWork: (int workDone) {
          store.dispatch(SetWork(workDone, goalID));
        },
      ),
      builder: (context, props) {
        Color color = props.goal.color;
        return Column(children: [
          Row(children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(1.2, 0.0),
                  colors: [
                    props.goal.color,
                    props.goal.color.withAlpha(140)
                  ], // whitish to gray
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ), //BoxDecoration(color: props.goal.color),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 5, right: 20, top: 50, bottom: 5),
                child: Column(children: [
                  Row(children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                        child: Text(props.goal.name,
                            style:
                                TextStyle(fontSize: 18, color: Colors.white))),
                    ClipOval(
                      child: Material(
                        color: color, // button color
                        child: InkWell(
                          splashColor: Colors.black, // inkwell color
                          child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Icon(Icons.edit, color: Colors.white)),
                          onTap: () async {
                            // String s = await showPendingNotifications();
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) => AlertDialog(
                            //     title: Text("Notifications"),
                            //     content: Text(s),
                            //   ),
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddGoalPage(goal: props.goal)),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(children: [
                    Padding(padding: EdgeInsets.only(left: 5)),
                    Text(props.goal.workString(),
                        style: TextStyle(color: Colors.white)),
                    Spacer(),
                    ClipOval(
                      child: Material(
                        color: Colors.white, // button color
                        child: InkWell(
                          splashColor: Colors.black, // inkwell color
                          child: SizedBox(
                              width: 35, height: 35, child: Icon(Icons.remove)),
                          onTap: () {
                            props.decrWork();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: TextField(
                          controller: TextEditingController()
                            ..text = props.goal.workDone.toString(),
                          onChanged: (String value) {
                            try {
                              int workDone = int.parse(value);
                              props.setWork(workDone);
                            } on FormatException {}
                          },
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.white, // button color
                        child: InkWell(
                          splashColor: Colors.black, // inkwell color
                          child: SizedBox(
                              width: 35, height: 35, child: Icon(Icons.add)),
                          onTap: () {
                            props.incrWork();
                          },
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
            ))
          ]),
          LinearProgressIndicator(
              value: props.goal.progress(),
              valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(
                  255, 255 - color.red, 255 - color.green, 255 - color.blue)),
              backgroundColor: props.goal.color),
        ]);
      },
    );
  }
}
