import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_task_page.dart';
import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';

typedef void _Action(Task task);

class _GoalProps {
  Goal goal;
  _Action remove;
  _Action cross;
  _GoalProps({this.goal, this.remove, this.cross});
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
            ),
        builder: (context, goalProps) {
          return Scaffold(
            appBar: AppBar(
              title: Text(goalProps.goal.name),
            ),
            body: new ListView.builder(
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
            ),
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
