import 'package:flutter/material.dart';

class CreateGoalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create goal'),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Goal name',
                  ),
              ),
          ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);

          },
          label: Text('Save'),
          backgroundColor: Colors.pink,
      ),
    );
  }
}
