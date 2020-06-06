import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/habit.dart';
import 'components/editable_title.dart';
import 'components/bottom_bar.dart';
import 'components/form_line.dart';
import 'components/form_divider.dart';
import 'components/chip_picker.dart';

class _Frequency {
  final String repr;
  final Duration duration;
  _Frequency({this.repr, this.duration});
}

List<_Frequency> periods = [
  _Frequency(repr: "30s", duration: Duration(seconds: 30)),
  _Frequency(repr: "5m", duration: Duration(minutes: 5)),
  _Frequency(repr: "Day", duration: Duration(days: 1)),
  _Frequency(repr: "Week", duration: Duration(days: 7)),
  _Frequency(repr: "Month", duration: Duration(days: 30)),
  _Frequency(repr: "Year", duration: Duration(days: 365))
];

class _Props {
  VoidCallback addHabit;
  Function(Habit) editHabit;
  final Goal goal;
  _Props({this.addHabit, this.editHabit, this.goal});
}

class _AddHabitPage extends State<AddHabitPage> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _objectiveController =
      new TextEditingController();
  String period;

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _nameController.text = widget.habit.name;
      _objectiveController.text = widget.habit.objective.toString();
      period = periods
          .firstWhere((period) => period.duration == widget.habit.period)
          .repr;
    } else {
      period = periods[0].repr;
      _objectiveController.text = '1';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _Props>(
        converter: (store) {
          return _Props(
            addHabit: () {
              try {
                int times = int.parse(_objectiveController.text);
                store.dispatch(AddHabit(Habit(
                    name: _nameController.text,
                    period: periods
                        .firstWhere((freq) => freq.repr == period)
                        .duration,
                    objective: times)));
              } on FormatException {}
            },
            editHabit: (habit) {
              store.dispatch(EditHabit(habit));
            },
            goal: store.state.goals
                .firstWhere((goal) => goal.id == store.state.selectedGoalID),
          );
        },
        builder: (context, props) {
          return Column(children: [
            EditableTitle(
              textController: _nameController,
              color: props.goal.color,
              hint: "Habit name",
            ),
            FormLine(
              name: "Every",
              child: ChipPicker(
                  values: periods.map((period) => period.repr).toList(),
                  value: period,
                  onChange: (String f) {
                    setState(() {
                      period = f;
                    });
                  }),
            ),
            FormDivider(),
            FormLine(
              name: "Times / $period",
              child: Expanded(
                  child: Row(children: [
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  cursorColor: Colors.black,
                  controller: _objectiveController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )),
              ])),
            ),
            FormDivider(),
            Spacer(),
            BottomBar(buttons: [
              Button(
                  label: "Cancel",
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              Button(
                  label: "Save",
                  onPressed: () {
                    if (widget.habit != null) {
                      try {
                        int objective = int.parse(_objectiveController.text);
                        props.editHabit(widget.habit.copyWith(
                            name: _nameController.text,
                            period: periods
                                .firstWhere((freq) => freq.repr == period)
                                .duration,
                            objective: objective));
                      } on FormatException {}
                    } else {
                      props.addHabit();
                    }
                    Navigator.pop(context);
                  })
            ]),
          ]);
        },
      ),
    );
  }
}

class AddHabitPage extends StatefulWidget {
  final Habit habit;
  AddHabitPage({this.habit});
  @override
  _AddHabitPage createState() => _AddHabitPage();
}
