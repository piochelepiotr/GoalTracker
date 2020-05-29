import 'package:flutter/material.dart';

class FormDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 0,
        color: Colors.grey,
      ),
    );
  }
}
