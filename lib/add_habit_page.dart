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
import 'components/unit_picker.dart';

List<String> frequences = ["Day", "Week", "Month", "Year"];

class _Props {
  VoidCallback addHabit;
  final Goal goal;
  _Props({this.addHabit, this.goal});
}

class _AddHabitPage extends State<AddHabitPage> {
  final TextEditingController _textController = new TextEditingController();
  final TextEditingController _timesController = new TextEditingController()
    ..text = '1';
  String frequence;

  @override
  void initState() {
    frequence = frequences[0];
    super.initState();
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
                    frequency: frequence,
                    times: times)));
              } on FormatException {}
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
                  values: frequences,
                  defaultValue: frequence,
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
                    props.addHabit();
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
  @override
  _AddHabitPage createState() => _AddHabitPage();
}
