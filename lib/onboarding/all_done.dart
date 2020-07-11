import 'package:flutter/material.dart';
import '../components/bottom_bar.dart';

class AllDoneOnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                                "images/Goal_app_onboarding_4.png")))))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
                "You’re all set, congratulations on your new goal! If you ever need more advice, click on the [logo] button - a library of tips and methods to keep you rolling every day.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center)),
        Padding(padding: EdgeInsets.only(top: 30)),
        BottomBar(buttons: [
          Button(
              label: "Let's Go!",
              onPressed: () {
                Navigator.pop(context);
              })
        ]),
        Padding(padding: EdgeInsets.only(top: 20)),
      ]),
    );
  }
}
