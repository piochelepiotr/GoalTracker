import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../model/goal.dart';
import '../model/action.dart';
import '../redux/state.dart';
import '../redux/actions.dart';
import '../goal_page/actions.dart';
import 'habits.dart';

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

class ActionsOnBoarding extends StatelessWidget {
  final int goalID;
  ActionsOnBoarding({this.goalID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(children: [
              Expanded(
                  child: StoreConnector<AppState, _Props>(
                      converter: (store) => _Props(
                            goal: store.state.getGoal(goalID),
                            remove: (ActionModel action) => {
                              store.dispatch(DeleteAction(action, goalID)),
                            },
                            cross: (ActionModel action) => {
                              store.dispatch(CrossAction(action, goalID)),
                            },
                            editAction: (ActionModel action) => {
                              store.dispatch(EditAction(action, goalID)),
                            },
                            addAction: (ActionModel action) {
                              store.dispatch(AddAction(action, goalID));
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HabitsOnBoarding(goalID: goalID)),
                              );
                            },
                          ),
                      builder: (context, props) {
                        return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView(children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment(1.2, 0.0),
                                    colors: [
                                      props.goal.color,
                                      props.goal.color.withAlpha(140)
                                    ], // whitish to gray
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 20),
                                  child: Row(children: [
                                    Text(
                                      props.goal.name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Spacer()
                                  ]),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              ActionsList(
                                goal: props.goal,
                                remove: props.remove,
                                cross: props.cross,
                                editAction: props.editAction,
                                addAction: props.addAction,
                              ),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              Row(children: [
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: AspectRatio(
                                            aspectRatio: 2078 / 1820,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: AssetImage(
                                                            "images/Goal_app_onboarding_3.png")))))))
                              ]),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "Now, let’s add more details into your goal. You can add "),
                                            TextSpan(
                                                text: "actions",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    " for one-time tasks. Simply press "),
                                            TextSpan(
                                                text: "done",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    " on your keyboard to add one."),
                                          ]))),
                              Padding(padding: EdgeInsets.only(top: 10)),
                            ]));
                      })),
              Padding(padding: EdgeInsets.only(top: 20)),
              Row(children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HabitsOnBoarding(goalID: goalID)),
                      );
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Skip", style: TextStyle(fontSize: 15)))),
              ]),
              Padding(padding: EdgeInsets.only(top: 20)),
            ])));
  }
}
