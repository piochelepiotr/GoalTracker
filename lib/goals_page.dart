import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_page.dart';
import 'redux/state.dart';
import 'model/goal.dart';
import 'redux/actions.dart';
import 'storage/database.dart';

typedef void _Remove(String goalName);

class _GoalsProps {
  List<Goal> goals;
  _Remove remove;
  _GoalsProps({this.goals, this.remove});
}

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('My Goals'),
        ),
        body: new StoreConnector<AppState, _GoalsProps>(
            converter: (store) => _GoalsProps(goals:store.state.goals, remove: (String goalName) => {
              store.dispatch(RemoveGoal(goalName)),
              DBProvider.db.deleteGoal(goalName),
            }),
            builder: (context, goalProps) {
              return new ListView.builder(
                  itemCount: goalProps.goals.length,
                  itemBuilder: (BuildContext context, int index) {
                    String name = goalProps.goals[index].name;
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
                        onDismissed: (DismissDirection direction) => { goalProps.remove(name) },
                    );
                  }
              );
            },
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGoalPage()),
              );

            },
            label: Text('Add Goal'),
            backgroundColor: Colors.pink,
        ),
    );
  }
}
