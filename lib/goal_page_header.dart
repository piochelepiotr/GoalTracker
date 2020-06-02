import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_page.dart';
import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';

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
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Props>(
      converter: (store) => _Props(
        goal: store.state.activeGoal(),
        incrWork: () => {
          store.dispatch(IncrWork()),
        },
        decrWork: () => {
          store.dispatch(DecrWork()),
        },
        setWork: (int workDone) => {
          store.dispatch(SetWork(workDone)),
        },
      ),
      builder: (context, props) {
        Color color = props.goal.color;
        List<Task> actions = props.goal.actions();
        List<Task> habits = props.goal.habits();
        return Column(children: [
          Row(children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(color: props.goal.color),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 5),
                child: Column(children: [
                  Row(children: [
                    Text(props.goal.name,
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    Spacer(),
                    ClipOval(
                      child: Material(
                        color: color, // button color
                        child: InkWell(
                          splashColor: Colors.black, // inkwell color
                          child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Icon(Icons.edit, color: Colors.white)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateGoalPage(goal: props.goal)),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(children: [
                    Text(props.goal.workString(),
                        style: TextStyle(color: Colors.grey)),
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
