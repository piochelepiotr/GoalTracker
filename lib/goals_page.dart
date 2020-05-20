import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_page.dart';
import 'redux/state.dart';

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('My Goals'),
        ),
        body: new StoreConnector<AppState, List<String>>(
            converter: (store) => store.state.goals,
            builder: (context, goals) {
              return new ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: goals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 50,
                        child: Center(child: Text('${goals[index]}')),
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
