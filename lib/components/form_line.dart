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
            onTap();
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(children: [
            Expanded(child: Text(name, style: TextStyle(fontSize: 18))),
            child,
          ]),
        ));
  }
}
