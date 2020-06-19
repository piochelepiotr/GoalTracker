import 'package:flutter/material.dart';
import 'model/habit.dart';
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(1.2, 0.0),
              colors: [color, color.withAlpha(140)], // whitish to gray
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 40),
            child: Row(children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                  child: Text(
                habit.name,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
            ]),
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
    ]));
  }
}
