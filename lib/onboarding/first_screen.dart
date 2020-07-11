import 'package:flutter/material.dart';
import '../components/bottom_bar.dart';
import 'add_goal.dart';

class FirstOnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(padding: EdgeInsets.only(top: 40)),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image:
                            AssetImage("images/add_goal_onboarding_1.png"))))),
        Padding(padding: EdgeInsets.only(top: 30)),
        Button(
            label: "Let’s get started on your goal journey!",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddGoalOnBoarding()),
              );
            }),
        Padding(padding: EdgeInsets.only(top: 20)),
      ]),
    );
  }
}
