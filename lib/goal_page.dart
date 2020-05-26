import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_task_page.dart';
import 'create_goal_page.dart';
import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';
import 'bottom_bar.dart';

typedef void _Action(Task task);
typedef void _SetWork(int workDone);

class _GoalProps {
  Goal goal;
  _Action remove;
  _Action cross;
  VoidCallback incrWork;
  VoidCallback decrWork;
  _SetWork setWork;
  _GoalProps(
      {this.goal,
      this.remove,
      this.cross,
      this.incrWork,
      this.decrWork,
      this.setWork});
}

class GoalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _GoalProps>(
        converter: (store) => _GoalProps(
              goal: store.state.goals
                  .firstWhere((goal) => goal.id == store.state.selectedGoalID),
              remove: (Task task) => {
                store.dispatch(RemoveTask(task)),
              },
              cross: (Task task) => {
                store.dispatch(CrossTask(task)),
              },
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
        builder: (context, goalProps) {
          Color color = goalProps.goal.color;
          return Scaffold(
            body: Column(children: [
              Row(children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(color: goalProps.goal.color),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 50, bottom: 5),
                    child: Column(children: [
                      Row(children: [
                        Text(goalProps.goal.name,
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
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
                                          CreateGoalPage(goal: goalProps.goal)),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      Row(children: [
                        Text(goalProps.goal.workString(),
                            style: TextStyle(color: Colors.grey)),
                        Spacer(),
                        ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.black, // inkwell color
                              child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Icon(Icons.remove)),
                              onTap: () {
                                goalProps.decrWork();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: TextField(
                              controller: TextEditingController()
                                ..text = goalProps.goal.workDone.toString(),
                              onChanged: (String value) {
                                try {
                                  int workDone = int.parse(value);
                                  goalProps.setWork(workDone);
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
                                  width: 35,
                                  height: 35,
                                  child: Icon(Icons.add)),
                              onTap: () {
                                goalProps.incrWork();
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
                  value: goalProps.goal.progress(),
                  valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(
                      255,
                      255 - color.red,
                      255 - color.green,
                      255 - color.blue)),
                  backgroundColor: goalProps.goal.color),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                Text("Actions", style: TextStyle(fontSize: 19)),
                Padding(padding: EdgeInsets.only(left: 5)),
                ClipOval(
                  child: Material(
                    color: Colors.grey, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Icon(Icons.add, color: Colors.white)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateTaskPage()),
                        );
                      },
                    ),
                  ),
                ),
                Spacer(),
                Text(goalProps.goal.tasksDone(),
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                Padding(padding: EdgeInsets.only(left: 10)),
              ]),
              Padding(padding: EdgeInsets.only(top: 5)),
              MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: goalProps.goal.tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      String name = goalProps.goal.tasks[index].name;
                      return Dismissible(
                        child: Card(
                          child: CheckboxListTile(
                            value: goalProps.goal.tasks[index].crossed,
                            title: Text(name,
                                style: goalProps.goal.tasks[index].crossed
                                    ? TextStyle(
                                        decoration: TextDecoration.lineThrough)
                                    : null),
                            onChanged: (bool value) => {
                              goalProps.cross(goalProps.goal.tasks[index]),
                            },
                          ),
                          margin: EdgeInsets.only(bottom: 4),
                        ),
                        key: Key(name),
                        background: Container(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.delete),
                          ),
                        ),
                        onDismissed: (DismissDirection direction) =>
                            {goalProps.remove(goalProps.goal.tasks[index])},
                        direction: DismissDirection.endToStart,
                      );
                    },
                  )),
              Padding(padding: EdgeInsets.only(top: 5)),
              Row(children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                Text("Habits", style: TextStyle(fontSize: 19)),
                Spacer(),
              ]),
              Spacer(),
              BottomBar(
                buttons: [
                  Button(
                    label: "Home",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ]),
          );
        });
  }
}
