import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'components/color_picker.dart';
import 'components/chip_picker.dart';
import 'components/bottom_bar.dart';
import 'components/editable_title.dart';
import 'components/form_line.dart';
import 'components/form_divider.dart';

List<String> units = ["Hours", "Minutes", "Months", "\$"];

class _Props {
  VoidCallback addGoal;
  bool Function() isDuplicate;
  _Props({this.addGoal, this.isDuplicate});
}

bool isDuplicate(List<Goal> goals, String goalName) {
  return goals.any((goal) => goal.name == goalName);
}

class _State extends State<AddGoalPage> {
  final TextEditingController _textController = new TextEditingController();
  final TextEditingController _totalProgressController =
      new TextEditingController();
  final TextEditingController _currentProgressController =
      new TextEditingController();
  Color goalColor = defaultPickerColor;
  String progressUnit = units[0];

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
            EditableTitle(
              textController: _textController,
              color: goalColor,
              hint: 'Goal name',
            ),
            FormLine(
              name: "Unit",
              child: ChipPicker(
                  values: units,
                  value: progressUnit,
                  onChange: (String unit) {
                    setState(() {
                      progressUnit = unit;
                    });
                  }),
            ),
            FormDivider(),
            FormLine(
              name: "Color",
              child: ColorPicker(
                  defaultColor: goalColor,
                  onColorChange: (Color color) {
                    setState(() {
                      goalColor = color;
                    });
                  }),
            ),
            FormDivider(),
            FormLine(
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
                    hintText: '0',
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
                Padding(padding: EdgeInsets.only(right: 5)),
                Text(progressUnit),
              ])),
            ),
            FormDivider(),
            FormLine(
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
                    hintText: '0',
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
                Padding(padding: EdgeInsets.only(right: 5)),
                Text(progressUnit),
              ])),
            ),
            FormDivider(),
            Spacer(),
            StoreConnector<AppState, _Props>(converter: (store) {
              return _Props(
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
            }, builder: (context, buttonActions) {
              return BottomBar(buttons: [
                Button(
                    label: "Cancel",
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                Button(
                    label: "Save",
                    onPressed: () {
                      if (buttonActions.isDuplicate()) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text(
                                    "You already have a goal with this name"),
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
                    })
              ]);
            }),
          ],
        ),
        alignment: Alignment.topCenter,
      ),
      // resizeToAvoidBottomInset: true,
    );
  }
}

class AddGoalPage extends StatefulWidget {
  final Goal goal;
  AddGoalPage({this.goal});
  @override
  _State createState() => _State();
}
