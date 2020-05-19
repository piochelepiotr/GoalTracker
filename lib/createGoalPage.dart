import 'package:flutter/material.dart';

class CreateGoalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create goal'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Save'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
