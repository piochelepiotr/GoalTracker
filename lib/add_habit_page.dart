import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/habit.dart';
import 'model/time.dart';
import 'components/editable_title.dart';
import 'components/bottom_bar.dart';
import 'components/form_line.dart';
import 'components/form_divider.dart';
import 'components/chip_picker.dart';
import 'components/datetime_picker.dart';
import 'components/weekday_picker.dart';
import 'notifications/notifications.dart';

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
  bool notifications = false;
  TimeOfDay notificationTime = TimeOfDay(hour: 19, minute: 0);
  List<bool> notificationDays = List<bool>.filled(7, true);

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _nameController.text = widget.habit.name;
      _objectiveController.text = widget.habit.objective.toString();
      period = getPeriodRepr(widget.habit.period);
      notifications = widget.habit.notifications;
      notificationTime = TimeOfDay(
          hour: widget.habit.notificationTime.hour,
          minute: widget.habit.notificationTime.minute);
      notificationDays = List<bool>.from(widget.habit.notificationDays);
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
            addHabit: () async {
              int times;
              try {
                times = int.parse(_objectiveController.text);
              } on FormatException {
                return;
              }
              Habit habit = Habit(
                  name: _nameController.text,
                  period: getPeriodDuration(period),
                  notifications: notifications,
                  notificationTime: TimeInDay(
                      hour: notificationTime.hour,
                      minute: notificationTime.minute),
                  notificationDays: notificationDays,
                  objective: times);
              List<int> ids = await updateHabitNotifications(
                  null, habit, store.state.activeGoal().name);
              store.dispatch(AddHabit(habit.copyWith(notificationIDs: ids)));
            },
            editHabit: (habit) async {
              List<int> ids = await updateHabitNotifications(
                  widget.habit, habit, store.state.activeGoal().name);
              store.dispatch(EditHabit(habit.copyWith(notificationIDs: ids)));
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
            FormLine(
              name: "Notifications",
              child: Switch(
                value: notifications,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
                activeTrackColor: props.goal.color.withAlpha(150),
                activeColor: props.goal.color,
              ),
            ),
            notifications
                ? FormLine(
                    name: "At",
                    child: DateTimePicker(
                      value: notificationTime,
                      onChanged: (TimeOfDay time) async {
                        setState(() {
                          notificationTime = time;
                        });
                      },
                      color: props.goal.color,
                    ),
                  )
                : Container(),
            notifications
                ? FormLine(
                    name: "On",
                    child: WeekDayPicker(
                      color: props.goal.color,
                      value: notificationDays,
                      onChange: (int index) {
                        setState(() {
                          notificationDays[index] = !notificationDays[index];
                        });
                      },
                    ),
                  )
                : Container(),
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
                      int objective;
                      try {
                        objective = int.parse(_objectiveController.text);
                      } on FormatException {
                        return;
                      }
                      props.editHabit(widget.habit.copyWith(
                        name: _nameController.text,
                        period: periods
                            .firstWhere((freq) => freq.repr == period)
                            .duration,
                        objective: objective,
                        notifications: notifications,
                        notificationTime: TimeInDay(
                            hour: notificationTime.hour,
                            minute: notificationTime.minute),
                        notificationDays: notificationDays,
                      ));
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
