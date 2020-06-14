import 'package:flutter/material.dart';

class Button {
  final String label;
  final VoidCallback onPressed;
  Button({this.label, this.onPressed});
}

class BottomBar extends StatelessWidget {
  final List<Button> buttons;
  BottomBar({this.buttons});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>();
    int i = 0;
    buttons.forEach((button) {
      if (buttons.length == 1 || i != 0) {
        children.add(Spacer());
      }
      children.add(RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 25),
        onPressed: button.onPressed,
        child: Text(button.label, style: TextStyle(fontSize: 15)),
        color: Colors.pink,
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      ));
      i++;
    });
    return Container(
        padding: EdgeInsets.only(right: 15, left: 15, bottom: 10, top: 5),
        child: Row(children: children));
  }
}
