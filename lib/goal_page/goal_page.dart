import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/state.dart';
import '../redux/actions.dart';
import '../components/bottom_bar.dart';
import 'actions.dart';
import 'habits.dart';
import 'header.dart';

class _GoalPage extends State<GoalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(children: [
            Expanded(
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(children: [
                      GoalPageHeader(goalID: widget.goalID),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      ActionsList(goalID: widget.goalID),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      HabitsList(goalID: widget.goalID),
                    ]))),
          ])),
    );
  }
}

class GoalPage extends StatefulWidget {
  final int goalID;
  GoalPage({@required this.goalID});

  @override
  _GoalPage createState() => _GoalPage();
}
