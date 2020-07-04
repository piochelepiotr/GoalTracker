import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'actions.dart';
import 'habits.dart';
import 'header.dart';
import '../components/onboarding_dialog.dart';
import '../redux/actions.dart';
import '../redux/state.dart';

class _Props {
  final bool doneOnboarding;
  final VoidCallback doOnboarding;
  _Props({this.doneOnboarding, this.doOnboarding});
}

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
            StoreConnector<AppState, _Props>(converter: (store) {
              return _Props(
                doOnboarding: () => store.dispatch(DoOnBoarding("goal_page")),
                doneOnboarding:
                    store.state.onBoardingDone.contains("goal_page"),
              );
            }, builder: (context, props) {
              return OnBoardingDialog(
                title: "The Goal Page",
                content:
                    "On the Goal Page, you can track the one time actions, and repeated actions (habits) that you need to take to achieve your goal.",
                dismissText: "OK",
                onDismiss: props.doOnboarding,
                show: !props.doneOnboarding,
              );
            }),
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
