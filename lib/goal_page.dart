import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_task_page.dart';
import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';
import 'storage/database.dart';

typedef void _Remove(Task task);

class _GoalProps {
  Goal goal;
  _Remove remove;
  _GoalProps({this.goal, this.remove});
}

class GoalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _GoalProps>(
        converter: (store) => _GoalProps(goal:store.state.goals.firstWhere((goal) => goal.id == store.state.selectedGoalID), remove: (Task task) => {
          store.dispatch(RemoveTask(task)),
          DBProvider.db.deleteTask(task.id),
        }),
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
                                title: Text(name),
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
                        onDismissed: (DismissDirection direction) => { goalProps.remove(goalProps.goal.tasks[index]) },
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
        }
    );
  }
}
