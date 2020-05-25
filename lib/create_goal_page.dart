import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'color_picker.dart';

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
  Color goalColor = defaultPickerColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          children: [
            Container(
              decoration: new BoxDecoration(color: goalColor),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: _textController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Goal name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(child: Text("Unit", style: TextStyle(fontSize: 18))),
                  Text("\$", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                      child: Text("Color", style: TextStyle(fontSize: 18))),
                  ColorPicker(onColorChange: (Color color) {
                    setState(() {
                      goalColor = color;
                    });
                  }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        alignment: Alignment.topCenter,
      ),
      floatingActionButton: new StoreConnector<AppState, _ButtonActions>(
        converter: (store) {
          return _ButtonActions(
              addGoal: () => {store.dispatch(AddGoal(_textController.text))},
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
