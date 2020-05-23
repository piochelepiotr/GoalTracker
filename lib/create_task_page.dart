import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/thunk.dart';
import 'redux/state.dart';
import 'model/goal.dart';

class _ButtonActions {
  VoidCallback addTask;
  _ButtonActions({this.addTask});
}

bool isDuplicate(List<Goal> goals, String goalName) {
  return goals.any((goal) => goal.name == goalName);
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create task'),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      hintText: 'Task name',
                  ),
              ),
          ),
      ),
      floatingActionButton: new StoreConnector<AppState, _ButtonActions>(
          converter: (store) {
            return _ButtonActions(
                addTask: () => { store.dispatch(addTask(store.state.selectedGoalID, _textController.text)) },
            );
          },
          builder: (context, buttonActions) {
            return FloatingActionButton.extended(
                onPressed: () {
                  buttonActions.addTask();
                  Navigator.pop(context);
                },
                label: Text('Save'),
                backgroundColor: Colors.pink,
            );
          },
      ),
    );
  }
}

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}
