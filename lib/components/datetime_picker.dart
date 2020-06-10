import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
  final TimeOfDay value;
  final Function(TimeOfDay) onChanged;
  final Color color;
  DateTimePicker({this.onChanged, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(value.format(context), style: TextStyle(fontSize: 18)),
      onTap: () async {
        TimeOfDay time = await showTimePicker(
          context: context,
          initialTime: value,
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: color,
                accentColor: color,
              ),
              child: child,
            );
          },
        );
        if (time != null) {
          onChanged(time);
        }
      },
    );
  }
}
