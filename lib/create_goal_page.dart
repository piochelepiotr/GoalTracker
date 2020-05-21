import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/actions.dart';
import 'redux/state.dart';
import 'storage/database.dart';
import 'model/goal.dart';

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
      floatingActionButton: new StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () => {
              store.dispatch(AddGoal(_textController.text))
            };
          },
          builder: (context, callback) {
            return FloatingActionButton.extended(
                onPressed: () {
                  DBProvider.db.newGoal(Goal(name:_textController.text));
                  callback();
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

class CreateGoalPage extends StatefulWidget {
  @override
  _CreateGoalPageState createState() => _CreateGoalPageState();
}
