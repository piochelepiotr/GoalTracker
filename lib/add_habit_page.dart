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
import 'analytics/analytics.dart';

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
  int objective = 1;
  bool notifications = true;
  TimeOfDay notificationTime = TimeOfDay(hour: 19, minute: 0);
  List<bool> notificationDays = List<bool>.filled(7, true);
  FocusNode objectiveFocusNode;

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _nameController.text = widget.habit.name;
      _objectiveController.text = widget.habit.objective.toString();
      objective = widget.habit.objective;
      period = getPeriodRepr(widget.habit.period);
      notifications = widget.habit.notifications;
      notificationTime = TimeOfDay(
          hour: widget.habit.notificationTime.hour,
          minute: widget.habit.notificationTime.minute);
      notificationDays = List<bool>.from(widget.habit.notificationDays);
    } else {
      period = periods[0].repr;
    }
    objectiveFocusNode = FocusNode();
  }

  @override
  void dispose() {
    objectiveFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _Props>(
        converter: (store) {
          return _Props(
            addHabit: () async {
              Habit habit = Habit(
                  name: _nameController.text,
                  period: getPeriodDuration(period),
                  notifications: notifications,
                  notificationTime: TimeInDay(
                      hour: notificationTime.hour,
                      minute: notificationTime.minute),
                  notificationDays: notificationDays,
                  objective: objective);
              List<int> ids = await updateHabitNotifications(
                  null, habit, store.state.getGoal(widget.goalID));
              store.dispatch(AddHabit(
                  habit.copyWith(notificationIDs: ids), widget.goalID));
            },
            editHabit: (habit) async {
              List<int> ids = await updateHabitNotifications(
                  widget.habit, habit, store.state.getGoal(widget.goalID));
              store.dispatch(EditHabit(
                  habit.copyWith(notificationIDs: ids), widget.goalID));
            },
            goal: store.state.getGoal(widget.goalID),
          );
        },
        builder: (context, props) {
          ChipPicker periodPicker = ChipPicker(
              values: periods.map((period) => period.repr).toList(),
              value: period,
              onChange: (String f) {
                setState(() {
                  period = f;
                });
              });
          DateTimePicker dateTimePicker = DateTimePicker(
            value: notificationTime,
            onChanged: (TimeOfDay time) async {
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                notificationTime = time;
              });
            },
            color: props.goal.color,
          );
          return Column(children: [
            Expanded(
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(children: [
                      EditableTitle(
                        textController: _nameController,
                        color: props.goal.color,
                        hint: "Habit name",
                      ),
                      FormLine(
                          name: "Every",
                          child: periodPicker,
                          onTap: () {
                            periodPicker.onTap(context);
                          }),
                      FormDivider(),
                      FormLine(
                          name: "Times / $period",
                          child: Expanded(
                              child: Row(children: [
                            Expanded(
                                child: TextField(
                              focusNode: objectiveFocusNode,
                              onChanged: (String quantity) {
                                try {
                                  setState(() {
                                    objective = int.parse(quantity);
                                  });
                                } on FormatException {
                                  objective = 1;
                                }
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              cursorColor: Colors.black,
                              controller: _objectiveController,
                              decoration: InputDecoration(
                                hintText: '1',
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            )),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2)),
                            Text("Time" + (objective == 1 ? '' : 's'),
                                style: TextStyle(color: Colors.grey)),
                          ])),
                          onTap: () {
                            objectiveFocusNode.requestFocus();
                          }),
                      FormDivider(),
                      FormLine(
                        onTap: () {
                          setState(() {
                            notifications = !notifications;
                          });
                        },
                        name: "Notifications",
                        child: Switch(
                          value: notifications,
                          onChanged: (value) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
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
                              child: dateTimePicker,
                              onTap: () {
                                dateTimePicker.onTap(context);
                              },
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
                                    notificationDays[index] =
                                        !notificationDays[index];
                                  });
                                },
                              ),
                            )
                          : Container(),
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
                    if (widget.habit != null) {
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
                      sendAnalyticsEvent("addHabit");
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
  final int goalID;
  AddHabitPage({this.habit, @required this.goalID});
  @override
  _AddHabitPage createState() => _AddHabitPage();
}
