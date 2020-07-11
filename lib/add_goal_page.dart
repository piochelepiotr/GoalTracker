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
import 'analytics/analytics.dart';
import 'goal_page/goal_page.dart';

List<String> units = [
  "Hours",
  "Days",
  "Weeks",
  "Months",
  "\$",
  "%",
  "Steps",
  "Times",
  "Chapters",
  "Pages",
  "Books",
  "Kgs",
  "Lbs"
];

class _Props {
  int Function() addGoal;
  bool Function() isDuplicate;
  final VoidCallback seenAddGoalOnBoarding;
  final bool doneAddGoalOnBoarding;
  _Props(
      {@required this.addGoal,
      @required this.isDuplicate,
      @required this.seenAddGoalOnBoarding,
      @required this.doneAddGoalOnBoarding});
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
  FocusNode totalWorkFocusNode;
  FocusNode workDoneFocusNode;

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _textController.text = widget.goal.name;
      goalColor = widget.goal.color;
      progressUnit = widget.goal.workUnit;
      _totalProgressController.text = widget.goal.totalWork.toString();
      _currentProgressController.text = widget.goal.workDone.toString();
    }
    totalWorkFocusNode = FocusNode();
    workDoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    totalWorkFocusNode.dispose();
    workDoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoreConnector<AppState, _Props>(converter: (store) {
      return _Props(
        addGoal: () {
          int totalWork = 0;
          int workDone = 0;
          try {
            totalWork = int.parse(_totalProgressController.text);
            workDone = int.parse(_currentProgressController.text);
          } on FormatException {}
          int goalID;
          bool newGoal = false;
          if (widget.goal == null) {
            goalID = store.state.nextGoalID();
            newGoal = true;
          } else {
            goalID = widget.goal.id;
          }
          store.dispatch(AddGoal(Goal(
            name: _textController.text,
            workUnit: progressUnit,
            totalWork: totalWork,
            workDone: workDone,
            color: goalColor,
            id: goalID,
          )));
          return newGoal ? goalID : null;
        },
        isDuplicate: () =>
            widget.goal == null &&
            isDuplicate(store.state.goals, _textController.text),
        seenAddGoalOnBoarding: () => store.dispatch(DoOnBoarding("add_goal")),
        doneAddGoalOnBoarding: store.state.onBoardingDone.contains("add_goal"),
      );
    }, builder: (context, props) {
      ChipPicker unitPicker = ChipPicker(
          values: units,
          value: progressUnit,
          onChange: (String unit) {
            setState(() {
              progressUnit = unit;
            });
          });
      ColorPicker colorPicker = ColorPicker(
          value: goalColor,
          onChange: (Color color) {
            setState(() {
              goalColor = color;
            });
          });
      return Column(
        children: [
          Expanded(
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(children: [
                    EditableTitle(
                      textController: _textController,
                      color: goalColor,
                      hint: 'Goal name',
                      autofocus: props.doneAddGoalOnBoarding,
                    ),
                    FormLine(
                      name: "Unit",
                      child: unitPicker,
                      onTap: () {
                        unitPicker.onTap(context);
                      },
                    ),
                    FormDivider(),
                    FormLine(
                      name: "Color",
                      child: colorPicker,
                      onTap: () {
                        colorPicker.onTap(context);
                      },
                    ),
                    FormDivider(),
                    FormLine(
                      name: "Total work required",
                      child: Expanded(
                          child: Row(children: [
                        Expanded(
                            child: TextField(
                          focusNode: totalWorkFocusNode,
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
                      onTap: () {
                        totalWorkFocusNode.requestFocus();
                      },
                    ),
                    FormDivider(),
                    FormLine(
                      name: "Work already done",
                      child: Expanded(
                          child: Row(children: [
                        Expanded(
                            child: TextField(
                          focusNode: workDoneFocusNode,
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
                      onTap: () {
                        workDoneFocusNode.requestFocus();
                      },
                    ),
                    FormDivider(),
                  ]))),
          BottomBar(buttons: [
            Button(
                label: "Cancel",
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Button(
                label: "Save",
                onPressed: () {
                  if (props.isDuplicate()) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content:
                                Text("You already have a goal with this name"),
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
                    sendAnalyticsEvent("addGoal");
                    int goalID = props.addGoal();
                    Navigator.pop(context);
                    if (goalID != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoalPage(goalID: goalID)),
                      );
                    }
                  }
                })
          ]),
        ],
      );
    }));
  }
}

class AddGoalPage extends StatefulWidget {
  final Goal goal;
  AddGoalPage({this.goal});
  @override
  _State createState() => _State();
}
