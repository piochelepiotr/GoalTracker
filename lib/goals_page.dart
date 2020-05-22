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
                  padding: const EdgeInsets.all(8),
                  itemCount: goals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text('${goals[index].name}'),
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
