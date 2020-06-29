import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  Button({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 25),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(fontSize: 15)),
      color: Colors.pink,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
    );
  }
}

class BottomBar extends StatelessWidget {
  final List<Widget> buttons;
  BottomBar({this.buttons});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>();
    int i = 0;
    buttons.forEach((button) {
      if (buttons.length == 1 || i != 0) {
        children.add(Spacer());
      }
      children.add(button);
      i++;
    });
    return Container(
        padding: EdgeInsets.only(right: 15, left: 15, bottom: 10, top: 5),
        child: Row(children: children));
  }
}
