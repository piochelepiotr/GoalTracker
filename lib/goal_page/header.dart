import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/state.dart';
import '../redux/actions.dart';
import '../model/goal.dart';
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
                    EdgeInsets.only(left: 5, right: 20, top: 20, bottom: 5),
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
                                TextStyle(fontSize: 20, color: Colors.white))),
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
                  Padding(padding: EdgeInsets.only(left: 5)),
                  Text(props.goal.workString(),
                      style: TextStyle(color: Colors.white)),
                  Row(children: [
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
                        child: Slider(
                      label: "hello", //props.goal.workString(),
                      inactiveColor: props.goal.color,
                      activeColor: Color.fromARGB(255, 255 - color.red,
                          255 - color.green, 255 - color.blue),
                      value: props.goal.workDone.toDouble(),
                      onChanged: (double workDone) {
                        props.setWork(workDone.round());
                      },
                      min: 0,
                      max: props.goal.totalWork.toDouble(),
                    )),
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
        ]);
      },
    );
  }
}
