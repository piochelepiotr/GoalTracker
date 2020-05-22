import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_page.dart';
import 'redux/state.dart';
import 'model/goal.dart';

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('My Goals'),
        ),
        body: new StoreConnector<AppState, List<Goal>>(
            converter: (store) => store.state.goals,
            builder: (context, goals) {
              return new ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        child: Card(
                            child: ListTile(
                                title: Text('${goals[index].name}'),
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
