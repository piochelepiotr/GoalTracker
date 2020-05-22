import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_page.dart';
import 'redux/state.dart';
import 'model/goal.dart';
import 'redux/actions.dart';

typedef void _Remove(int index);

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
            converter: (store) => _GoalsProps(goals:store.state.goals, remove: (int index) => { store.dispatch(RemoveGoal(index)) }),
            builder: (context, goalProps) {
              return new ListView.builder(
                  itemCount: goalProps.goals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        child: Card(
                            child: ListTile(
                                title: Text('${goalProps.goals[index].name}'),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 2),
                        ),
                        key: Key(index.toString()),
                        background: Container(
                            color: Colors.red,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete),
                            ),
                        ),
                        onDismissed: (DismissDirection direction) => { goalProps.remove(index) },
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
