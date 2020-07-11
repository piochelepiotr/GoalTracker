import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'actions.dart';
import 'habits.dart';
import 'header.dart';
import '../redux/actions.dart';
import '../redux/state.dart';
import '../model/action.dart';
import '../model/goal.dart';
import '../onboarding/onboarding_pusher.dart';
import '../onboarding/actions.dart';
import 'achievement.dart';

class _OnBoardingProps {
  final bool doneOnboarding;
  final VoidCallback doOnboarding;
  _OnBoardingProps({this.doneOnboarding, this.doOnboarding});
}

class _Props {
  Goal goal;
  Function(ActionModel) remove;
  Function(ActionModel) editAction;
  Function(ActionModel) addAction;
  Function(ActionModel) cross;

  _Props({
    @required this.goal,
    @required this.remove,
    @required this.cross,
    @required this.editAction,
    @required this.addAction,
  });
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
            StoreConnector<AppState, _OnBoardingProps>(converter: (store) {
              return _OnBoardingProps(
                doOnboarding: () => store.dispatch(DoOnBoarding("goal_page")),
                doneOnboarding:
                    store.state.onBoardingDone.contains("goal_page"),
              );
            }, builder: (context, props) {
              return OnBoardingPusher(
                  show: !props.doneOnboarding,
                  onInit: () {
                    props.doOnboarding();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ActionsOnBoarding(goalID: widget.goalID)),
                    );
                  });
            }),
            Expanded(
                child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: StoreConnector<AppState, _Props>(converter: (store) {
                return _Props(
                  goal: store.state.getGoal(widget.goalID),
                  remove: (ActionModel action) => {
                    store.dispatch(DeleteAction(action, widget.goalID)),
                  },
                  cross: (ActionModel action) => {
                    store.dispatch(CrossAction(action, widget.goalID)),
                  },
                  editAction: (ActionModel action) => {
                    store.dispatch(EditAction(action, widget.goalID)),
                  },
                  addAction: (ActionModel action) => {
                    store.dispatch(AddAction(action, widget.goalID)),
                  },
                );
              }, builder: (context, props) {
                return ListView(children: [
                  GoalPageHeader(goalID: widget.goalID),
                  Row(children: [
                    Expanded(
                        child: FractionallySizedBox(
                            widthFactor: 0.5,
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: DonutPieChart(
                                    workDone: props.goal.progress(),
                                    color: props.goal.color))))
                  ]),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  ActionsList(
                      goal: props.goal,
                      remove: props.remove,
                      cross: props.cross,
                      editAction: props.editAction,
                      addAction: props.addAction),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  HabitsList(goalID: widget.goalID),
                ]);
              }),
            )),
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
