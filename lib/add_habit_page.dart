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
  final Duration period;
  _Frequency({this.repr, this.period});
}

List<_Frequency> frequences = [
  _Frequency(repr: "5m", period: Duration(minutes: 5)),
  _Frequency(repr: "Day", period: Duration(days: 1)),
  _Frequency(repr: "Week", period: Duration(days: 7)),
  _Frequency(repr: "Month", period: Duration(days: 30)),
  _Frequency(repr: "Year", period: Duration(days: 365))
];

class _Props {
  VoidCallback addHabit;
  Function(Habit) editHabit;
  final Goal goal;
  _Props({this.addHabit, this.editHabit, this.goal});
}

class _AddHabitPage extends State<AddHabitPage> {
  final TextEditingController _textController = new TextEditingController();
  final TextEditingController _timesController = new TextEditingController();
  String frequence;

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _textController.text = widget.habit.name;
      _timesController.text = widget.habit.times.toString();
      frequence = frequences
          .firstWhere((freq) => freq.period == widget.habit.period)
          .repr;
    } else {
      frequence = frequences[0].repr;
      _timesController.text = '1';
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
                int times = int.parse(_timesController.text);
                store.dispatch(AddHabit(Habit(
                    name: _textController.text,
                    period: frequences
                        .firstWhere((freq) => freq.repr == frequence)
                        .period,
                    times: times)));
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
              textController: _textController,
              color: props.goal.color,
              hint: "Habit name",
            ),
            FormLine(
              name: "Every",
              child: ChipPicker(
                  values: frequences.map((period) => period.repr).toList(),
                  value: frequence,
                  onChange: (String f) {
                    setState(() {
                      frequence = f;
                    });
                  }),
            ),
            FormDivider(),
            FormLine(
              name: "Times / $frequence",
              child: Expanded(
                  child: Row(children: [
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  cursorColor: Colors.black,
                  controller: _timesController,
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
                        int times = int.parse(_timesController.text);
                        props.editHabit(widget.habit.copyWith(
                            name: _textController.text,
                            frequency: frequences
                                .firstWhere((freq) => freq.repr == frequence)
                                .period,
                            times: times));
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
