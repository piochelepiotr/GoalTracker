import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'color_picker.dart';
import 'unit_picker.dart';

typedef bool _Check();

class _ButtonActions {
  VoidCallback addGoal;
  _Check isDuplicate;
  _ButtonActions({this.addGoal, this.isDuplicate});
}

bool isDuplicate(List<Goal> goals, String goalName) {
  return goals.any((goal) => goal.name == goalName);
}

class _Line extends StatelessWidget {
  final Widget child;
  final String name;
  _Line({this.child, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(children: [
        Expanded(child: Text(name, style: TextStyle(fontSize: 18))),
        child,
      ]),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 0,
        color: Colors.grey,
      ),
    );
  }
}

class _CreateGoalPageState extends State<CreateGoalPage> {
  final TextEditingController _textController = new TextEditingController();
  final TextEditingController _totalProgressController =
      new TextEditingController();
  final TextEditingController _currentProgressController =
      new TextEditingController();
  Color goalColor = defaultPickerColor;
  String progressUnit = defaultPickerUnit;

  @override
  void initState() {
    if (widget.goal != null) {
      _textController.text = widget.goal.name;
      goalColor = widget.goal.color;
      progressUnit = widget.goal.workUnit;
      _totalProgressController.text = widget.goal.totalWork.toString();
      _currentProgressController.text = widget.goal.workDone.toString();
    }
    super.initState();
  }

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
            _Line(
              name: "Unit",
              child: UnitPicker(
                  defaultUnit: progressUnit,
                  onUnitChange: (String unit) {
                    setState(() {
                      progressUnit = unit;
                    });
                  }),
            ),
            _Divider(),
            _Line(
              name: "Color",
              child: ColorPicker(
                  defaultColor: goalColor,
                  onColorChange: (Color color) {
                    setState(() {
                      goalColor = color;
                    });
                  }),
            ),
            _Divider(),
            _Line(
              name: "Total work required",
              child: Expanded(
                  child: Row(children: [
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  cursorColor: Colors.black,
                  controller: _totalProgressController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
                Text(progressUnit),
              ])),
            ),
            _Divider(),
            _Line(
              name: "Work already done",
              child: Expanded(
                  child: Row(children: [
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  cursorColor: Colors.black,
                  controller: _currentProgressController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
                Text(progressUnit),
              ])),
            ),
            _Divider(),
          ],
        ),
        alignment: Alignment.topCenter,
      ),
      // bottomNavigationBar: BottomAppBar(
      //     color: Colors.white,
      //     child: Text("hello"),
      // ),
      floatingActionButton: new StoreConnector<AppState, _ButtonActions>(
        converter: (store) {
          return _ButtonActions(
              addGoal: () {
                int totalWork = 0;
                int workDone = 0;
                try {
                  totalWork = int.parse(_totalProgressController.text);
                  workDone = int.parse(_currentProgressController.text);
                } on FormatException {}
                store.dispatch(AddGoal(Goal(
                  name: _textController.text,
                  workUnit: progressUnit,
                  totalWork: totalWork,
                  workDone: workDone,
                  color: goalColor,
                  id: widget.goal != null ? widget.goal.id : null,
                )));
              },
              isDuplicate: () =>
                  widget.goal == null &&
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
  final Goal goal;
  CreateGoalPage({this.goal});
  @override
  _CreateGoalPageState createState() => _CreateGoalPageState();
}
