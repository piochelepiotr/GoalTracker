import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../model/goal.dart';
import '../model/habit.dart';
import '../redux/state.dart';
import '../goal_page/habits.dart';
import 'all_done.dart';
import '../redux/actions.dart';
import '../notifications/notifications.dart';

class _Props {
  Goal goal;
  final Function(Habit) removeHabit;
  final Function(Habit) editHabit;
  final Function(Habit) incrHabitAchieved;
  final Function(Habit) decrHabitAchieved;
  final Function(int oldIndex, int newIndex) reOrder;

  _Props({
    @required this.goal,
    @required this.removeHabit,
    @required this.editHabit,
    @required this.reOrder,
    @required this.incrHabitAchieved,
    @required this.decrHabitAchieved,
  });
}

class HabitsOnBoarding extends StatelessWidget {
  final int goalID;
  HabitsOnBoarding({this.goalID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(children: [
              StoreConnector<AppState, _Props>(
                  converter: (store) => _Props(
                        goal: store.state.getGoal(goalID),
                        removeHabit: (Habit habit) async {
                          await removeHabitNotifications(habit);
                          store.dispatch(DeleteHabit(habit, goalID));
                        },
                        editHabit: (Habit habit) => {
                          store.dispatch(EditHabit(habit, goalID)),
                        },
                        incrHabitAchieved: (Habit habit) {
                          if (habit.achieved < habit.objective) {
                            store.dispatch(AddGoalActivity(goalID, 1));
                          }
                          store.dispatch(IncrHabitAchieved(habit, goalID));
                        },
                        decrHabitAchieved: (Habit habit) {
                          if (habit.achieved > 0) {
                            store.dispatch(AddGoalActivity(goalID, -1));
                          }
                          store.dispatch(DecrHabitAchieved(habit, goalID));
                        },
                        reOrder: (int oldIndex, int newIndex) {
                          store.dispatch(
                              ReOrderHabits(oldIndex, newIndex, goalID));
                        },
                      ),
                  builder: (context, props) {
                    return Expanded(
                        child: MediaQuery.removePadding(
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
                              HabitsList(
                                  goal: props.goal,
                                  remove: props.removeHabit,
                                  editHabit: props.editHabit,
                                  reOrder: props.reOrder,
                                  incrHabitAchieved: props.incrHabitAchieved,
                                  decrHabitAchieved: props.decrHabitAchieved,
                                  addCallback: () {
                                    Navigator.pop(context);
                                  }),
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
                                                            "images/Goal_onboarding_4.png")))))))
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
                                            TextSpan(text: "You can also add "),
                                            TextSpan(
                                                text: "habits",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    " for regular tasks. Set them up to get a proper reminder and start tracking your progress."),
                                          ]))),
                              Padding(padding: EdgeInsets.only(top: 10)),
                            ])));
                  }),
              Padding(padding: EdgeInsets.only(top: 20)),
              Row(children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllDoneOnBoarding()),
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
