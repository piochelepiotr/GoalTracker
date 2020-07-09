import 'package:flutter/material.dart';

const days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

class DayPicker extends StatelessWidget {
  final String day;
  final bool selected;
  final VoidCallback onSelected;
  final Color color;
  DayPicker({this.day, this.selected, this.onSelected, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: GestureDetector(
          child: SizedBox(
            height: 35,
            width: 35,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: selected ? color : Colors.white,
                border: Border.all(color: color),
              ),
              child: Center(
                  child: Text(day[0],
                      style:
                          TextStyle(color: selected ? Colors.white : color))),
            ),
          ),
          onTap: onSelected,
        ));
  }
}

class WeekDayPicker extends StatelessWidget {
  final List<bool> value;
  final Color color;
  final Function(int index) onChange;

  WeekDayPicker({this.onChange, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (int i = 0; i < days.length; i++)
        DayPicker(
            day: days[i],
            color: color,
            selected: value[i],
            onSelected: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              onChange(i);
            }),
    ]);
  }
}
