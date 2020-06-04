import 'package:flutter/material.dart';

class EditableTitle extends StatelessWidget {
  final Color color;
  final String hint;
  final TextEditingController textController;
  EditableTitle({this.color, this.hint, this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: color),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
        child: TextField(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: textController,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
