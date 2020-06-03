import 'package:flutter/material.dart';

class TextEdit extends StatelessWidget {
  final VoidCallback onFocus;
  final Function(String) onSubmitted;
  final TextEditingController controller;
  final String hint;

  TextEdit({this.onFocus, this.onSubmitted, this.controller, this.hint});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: TextField(
              keyboardType: TextInputType.text,
              maxLines: null,
              onTap: onFocus,
              onSubmitted: onSubmitted,
              controller: controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: hint,
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            )));
  }
}
