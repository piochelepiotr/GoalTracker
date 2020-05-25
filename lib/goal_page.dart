import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_task_page.dart';
import 'create_goal_page.dart';
import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';

typedef void _Action(Task task);

class _GoalProps {
  Goal goal;
  _Action remove;
  _Action cross;
  VoidCallback incrWork;
  VoidCallback decrWork;
  _GoalProps(
      {this.goal, this.remove, this.cross, this.incrWork, this.decrWork});
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
                        Text(
                            "${goalProps.goal.workDone} / ${goalProps.goal.totalWork} ${goalProps.goal.workUnit} done",
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
                        Padding(padding: EdgeInsets.only(right: 10)),
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
              Expanded(
                  child: ListView.builder(
                itemCount: goalProps.goal.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  String name = goalProps.goal.tasks[index].name;
                  return Dismissible(
                    child: Card(
                      child: ListTile(
                        title: Text(name,
                            style: goalProps.goal.tasks[index].crossed
                                ? TextStyle(
                                    decoration: TextDecoration.lineThrough)
                                : null),
                        onTap: () => {
                          goalProps.cross(goalProps.goal.tasks[index]),
                        },
                      ),
                      margin: EdgeInsets.symmetric(vertical: 2),
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
              ))
            ]),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateTaskPage()),
                );
              },
              label: Text('Add Task'),
              backgroundColor: Colors.pink,
            ),
          );
        });
  }
}
