import 'package:flutter/material.dart';

class FormLine extends StatelessWidget {
  final Widget child;
  final String name;
  final VoidCallback onTap;
  FormLine({this.child, this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onTap != null) {
            FocusScope.of(context).requestFocus(new FocusNode());
            onTap();
          }
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(children: [
            Expanded(child: Text(name, style: TextStyle(fontSize: 18))),
            child,
          ]),
        ));
  }
}
