import 'package:flutter/material.dart';

class FormLine extends StatelessWidget {
  final Widget child;
  final String name;
  FormLine({this.child, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(children: [
        Expanded(child: Text(name, style: TextStyle(fontSize: 18))),
        child,
      ]),
    );
  }
}
