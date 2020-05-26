import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_goal_page.dart';
import 'goal_page.dart';
import 'redux/state.dart';
import 'model/goal.dart';
import 'redux/actions.dart';
import 'quote.dart';

typedef void _Action(int goalID);

class _GoalsProps {
  List<Goal> goals;
  _Action remove;
  _Action select;
  _GoalsProps({this.goals, this.remove, this.select});
}

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new StoreConnector<AppState, _GoalsProps>(
        converter: (store) => _GoalsProps(
          goals: store.state.goals,
          remove: (int goalID) => {
            store.dispatch(RemoveGoal(goalID)),
          },
          select: (int goalID) => {store.dispatch(SelectGoal(goalID))},
        ),
        builder: (context, goalProps) {
          return Column(children: [
            Quote(),
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: goalProps.goals.length,
                  itemBuilder: (BuildContext context, int index) {
                    Goal goal = goalProps.goals[index];
                    return Dismissible(
                      child: Card(
                        child: ListTile(
                            title: Text(goal.name,
                                style: TextStyle(color: goal.color)),
                            subtitle: Text(goal.workString()),
                            onTap: () => {
                                  goalProps.select(goal.id),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GoalPage()),
                                  )
                                }),
                        margin: EdgeInsets.symmetric(vertical: 2),
                      ),
                      key: Key(goal.id.toString()),
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete),
                        ),
                      ),
                      onDismissed: (DismissDirection direction) =>
                          {goalProps.remove(goal.id)},
                      direction: DismissDirection.endToStart,
                    );
                  },
                ))
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateGoalPage()),
          );
        },
        label: Text("Add Goal"),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
