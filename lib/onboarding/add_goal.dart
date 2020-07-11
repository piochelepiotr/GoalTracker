import 'package:flutter/material.dart';
import '../components/bottom_bar.dart';
import '../analytics/analytics.dart';
import '../add_goal_page.dart';

class AddGoalOnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        Expanded(
            child: Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                                "images/add_goal_onboarding_2.png")))))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
                "Let’s add your first goal. It should be general - such as “Stay fit” or “Learn a new language”. You can always edit it anytime.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center)),
        Padding(padding: EdgeInsets.only(top: 30)),
        BottomBar(buttons: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Skip", style: TextStyle(fontSize: 15)))),
          Button(
              label: "Add Goal",
              onPressed: () {
                sendAnalyticsEvent("addGoalStartOnBoarding");
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddGoalPage()),
                );
              })
        ]),
        Padding(padding: EdgeInsets.only(top: 20)),
      ]),
    );
  }
}
