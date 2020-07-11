import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/state.dart';
import '../redux/actions.dart';
import '../model/goal.dart';
import '../model/habit.dart';
import '../add_habit_page.dart';
import '../components/refresher.dart';
import '../components/round_icon_button.dart';
import '../habit_history_page/habit_history_page.dart';
import '../notifications/notifications.dart';
import '../analytics/analytics.dart';

class _Props {
  Goal goal;
  Function(Habit) remove;
  Function(Habit) editHabit;
  Function(Habit) incrHabitAchieved;
  Function(Habit) decrHabitAchieved;
  Function(int oldIndex, int newIndex) reOrder;

  _Props({
    @required this.goal,
    @required this.remove,
    @required this.editHabit,
    @required this.reOrder,
    @required this.incrHabitAchieved,
    @required this.decrHabitAchieved,
  });
}

class HabitsList extends StatefulWidget {
  final int goalID;
  final VoidCallback addCallback;
  HabitsList({@required this.goalID, this.addCallback});

  @override
  _HabitsList createState() => _HabitsList();
}

class _HabitsList extends State<HabitsList> {
  int selectedHabitID;
  @override
  void initState() {
    super.initState();
  }

  void addHabit() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (widget.addCallback != null) {
      widget.addCallback();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddHabitPage(goalID: widget.goalID)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Props>(
      converter: (store) => _Props(
          goal:
              store.state.goals.firstWhere((goal) => goal.id == widget.goalID),
          remove: (Habit habit) async {
            await removeHabitNotifications(habit);
            store.dispatch(DeleteHabit(habit, widget.goalID));
          },
          editHabit: (Habit habit) => {
                store.dispatch(EditHabit(habit, widget.goalID)),
              },
          incrHabitAchieved: (Habit habit) => {
                store.dispatch(IncrHabitAchieved(habit, widget.goalID)),
              },
          decrHabitAchieved: (Habit habit) => {
                store.dispatch(DecrHabitAchieved(habit, widget.goalID)),
              },
          reOrder: (int oldIndex, int newIndex) {
            store.dispatch(ReOrderHabits(oldIndex, newIndex, widget.goalID));
          }),
      builder: (context, props) {
        VoidCallback refresh = () {
          for (Habit habit in props.goal.habits) {
            if (habit.shouldUpdate()) {
              Habit updatedHabit = habit.copyWith();
              props.editHabit(updatedHabit);
            }
          }
        };
        return Column(children: [
          Refresher(refresh: refresh),
          Row(children: [
            Padding(padding: EdgeInsets.only(left: 10)),
            Text("Habits", style: TextStyle(fontSize: 19)),
            Spacer(),
          ]),
          Padding(padding: EdgeInsets.only(top: 5)),
          Column(
            // onReorder: (oldIndex, newIndex) {
            //   props.reOrder(oldIndex, newIndex);
            //},
            children: [
              for (final habit in props.goal.habits)
                Card(
                  key: Key(habit.id.toString()),
                  child: Column(children: [
                    ListTile(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (selectedHabitID == habit.id) {
                          setState(() {
                            selectedHabitID = null;
                          });
                        } else {
                          sendAnalyticsEvent("expandHabitEasy");
                          setState(() {
                            selectedHabitID = habit.id;
                          });
                        }
                      },
                      title: Row(children: [
                        Expanded(
                            child: Text(habit.name,
                                style: TextStyle(color: props.goal.color))),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text(habit.historySummary(),
                            style: TextStyle(color: Colors.grey, fontSize: 12))
                      ]),
                      subtitle: Text(habit.workRemaining),
                      trailing: PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert),
                        onSelected: (String selected) {
                          if (selected == "delete") {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(habit.name),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            "Are you sure you want to delete that habit?"),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text('Cancel'),
                                      onPressed: Navigator.of(context).pop,
                                    ),
                                    FlatButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        sendAnalyticsEvent("deleteHabit");
                                        props.remove(habit);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (selected == "edit") {
                            sendAnalyticsEvent("editHabit");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddHabitPage(
                                      habit: habit, goalID: widget.goalID)),
                            );
                          } else if (selected == "expand") {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "You can simply click on a habit to expand or collapse it")));
                            sendAnalyticsEvent("expandHabit");
                            setState(() {
                              selectedHabitID = habit.id;
                            });
                          } else if (selected == "collapse") {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "You can simply click on a habit to expand or collapse it")));
                            setState(() {
                              selectedHabitID = null;
                            });
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          selectedHabitID == habit.id
                              ? const PopupMenuItem<String>(
                                  value: "collapse",
                                  child: Text('Collapse'),
                                )
                              : const PopupMenuItem<String>(
                                  value: "expand",
                                  child: Text('Expand'),
                                ),
                          const PopupMenuItem<String>(
                            value: "edit",
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
                            value: "delete",
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ),
                    if (selectedHabitID == habit.id)
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 10)),
                          RoundIconButton(
                            color: props.goal.color,
                            secondaryColor: Colors.white,
                            onTap: () {
                              props.decrHabitAchieved(habit);
                            },
                            icon: Icons.remove,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          RoundIconButton(
                            color: props.goal.color,
                            secondaryColor: Colors.white,
                            onTap: () {
                              props.incrHabitAchieved(habit);
                            },
                            icon: Icons.add,
                          ),
                          Spacer(),
                          RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HabitHistoryPage(
                                        habit: habit, color: props.goal.color)),
                              );
                            },
                            child: Text("View History",
                                style: TextStyle(fontSize: 15)),
                            color: props.goal.color,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                          ),
                          Padding(padding: EdgeInsets.only(left: 5)),
                          RoundIconButton(
                            color: props.goal.color,
                            secondaryColor: Colors.white,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddHabitPage(
                                          habit: habit,
                                          goalID: widget.goalID)));
                            },
                            icon: Icons.edit,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                        ],
                      )
                  ]),
                  margin: EdgeInsets.symmetric(vertical: 2),
                )
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          GestureDetector(
            onTap: () {
              addHabit();
            },
            child: Row(children: [
              Padding(padding: EdgeInsets.only(left: 15)),
              Icon(Icons.add, color: Colors.grey),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                "Add Habit",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ]),
          ),
        ]);
      },
    );
  }
}
