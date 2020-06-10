import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'add_goal_page.dart';
import 'goal_page/goal_page.dart';
import 'redux/state.dart';
import 'model/goal.dart';
import 'redux/actions.dart';
import 'quote.dart';
import 'notifications/notifications.dart';
import 'notifications/helper.dart';

class _Props {
  List<Goal> goals;
  Function(int) remove;
  Function(int) select;
  Function(int oldIndex, int newIndex) reOrder;
  _Props({this.goals, this.remove, this.select, this.reOrder});
}

class GoalsPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GoalsPage> {
  @override
  void initState() {
    super.initState();
    initNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new StoreConnector<AppState, _Props>(
        converter: (store) => _Props(
          goals: store.state.goals,
          remove: (int goalID) => {
            store.dispatch(DeleteGoal(goalID)),
          },
          reOrder: (int oldIndex, int newIndex) => {
            store.dispatch(ReOrderGoals(oldIndex, newIndex)),
          },
          select: (int goalID) => {store.dispatch(SelectGoal(goalID))},
        ),
        builder: (context, props) {
          return Column(children: [
            Quote(),
            Expanded(
                child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                print("reorder $oldIndex -> $newIndex");
                props.reOrder(oldIndex, newIndex);
              },
              children: [
                for (final goal in props.goals)
                  Dismissible(
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        title: Text(goal.name,
                            style: TextStyle(color: goal.color)),
                        subtitle: Text(goal.workString()),
                        onTap: () => {
                          // showOngoingNotification(notifications,
                          //     title: 'Tite', body: 'Body'),
                          props.select(goal.id),
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GoalPage()),
                          )
                        },
                      ),
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
                        {props.remove(goal.id)},
                    direction: DismissDirection.endToStart,
                  )
              ],
            ))
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddGoalPage()),
          );
        },
        label: Text("Add Goal"),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
