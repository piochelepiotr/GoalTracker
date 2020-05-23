import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/thunk.dart';
import 'redux/state.dart';
import 'model/goal.dart';

typedef bool _Check();

class _ButtonActions {
  VoidCallback addGoal;
  _Check isDuplicate;
  _ButtonActions({this.addGoal, this.isDuplicate});
}

bool isDuplicate(List<Goal> goals, String goalName) {
  return goals.any((goal) => goal.name == goalName);
}

class _CreateGoalPageState extends State<CreateGoalPage> {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create goal'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Goal name',
            ),
          ),
        ),
      ),
      floatingActionButton: new StoreConnector<AppState, _ButtonActions>(
        converter: (store) {
          return _ButtonActions(
              addGoal: () => {store.dispatch(addGoal(_textController.text))},
              isDuplicate: () =>
                  isDuplicate(store.state.goals, _textController.text));
        },
        builder: (context, buttonActions) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (buttonActions.isDuplicate()) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("You already have a goal with this name"),
                        actions: [
                          FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ],
                      );
                    });
              } else {
                buttonActions.addGoal();
                Navigator.pop(context);
              }
            },
            label: Text('Save'),
            backgroundColor: Colors.pink,
          );
        },
      ),
    );
  }
}

class CreateGoalPage extends StatefulWidget {
  @override
  _CreateGoalPageState createState() => _CreateGoalPageState();
}
