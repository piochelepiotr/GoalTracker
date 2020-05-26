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
    children.add(Padding(padding: EdgeInsets.only(right: 15)));
    int i = 0;
    buttons.forEach((button) {
      children.add(RaisedButton(
        onPressed: button.onPressed,
        child: Text(button.label),
        color: Colors.pink,
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      ));
      if (buttons.length > 1 && i != (buttons.length - 1)) {
        children.add(Spacer());
      }
      i++;
    });
    children.add(Padding(padding: EdgeInsets.only(right: 15)));
    return Container(
        decoration: BoxDecoration(color: Colors.black12),
        child: Row(children: children));
  }
}
