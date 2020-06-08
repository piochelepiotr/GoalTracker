import 'package:flutter/material.dart';
import 'model/habit.dart';
import 'components/bottom_bar.dart';
import 'components/form_line.dart';
import 'components/form_divider.dart';

class HabitHistoryPage extends StatelessWidget {
  final Habit habit;
  final Color color;
  HabitHistoryPage({this.habit, this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Row(children: [
        Expanded(
            child: Container(
          decoration: new BoxDecoration(color: color),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
            child: Center(
                child: Text(
              habit.name,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
        ))
      ]),
      FormLine(name: "Frequency", child: Text(getPeriodRepr(habit.period))),
      FormDivider(),
      FormLine(
          name: "Achieved",
          child: Text(
              "${habit.getAchievedHabits()}/${habit.habitHistory.length}")),
      FormDivider(),
      FormLine(
          name: "Current Strike",
          child: Text(habit.getLastStrike().toString())),
      FormDivider(),
      FormLine(
          name: "Longest Strike",
          child: Text(habit.getLongestStrike().toString())),
      FormDivider(),
      Spacer(),
      BottomBar(
        buttons: [
          Button(
            label: "Back",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ]));
  }
}
