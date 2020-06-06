import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/state.dart';
import '../redux/actions.dart';
import '../model/goal.dart';
import '../model/habit.dart';
import '../add_habit_page.dart';
import 'package:reorderables/reorderables.dart';

class _Props {
  Goal goal;
  Function(Habit) remove;
  Function(Habit) editHabit;
  Function(int oldIndex, int newIndex) reOrder;

  _Props({
    this.goal,
    this.remove,
    this.editHabit,
    this.reOrder,
  });
}

class HabitsList extends StatefulWidget {
  HabitsList();

  @override
  _HabitsList createState() => _HabitsList();
}

class _HabitsList extends State<HabitsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Props>(
      converter: (store) => _Props(
          goal: store.state.goals
              .firstWhere((goal) => goal.id == store.state.selectedGoalID),
          remove: (Habit habit) => {
                store.dispatch(DeleteHabit(habit)),
              },
          editHabit: (Habit habit) => {
                store.dispatch(EditHabit(habit)),
              },
          reOrder: (int oldIndex, int newIndex) {
            store.dispatch(ReOrderHabits(oldIndex, newIndex));
          }),
      builder: (context, props) {
        return Column(children: [
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
                  child: ListTile(
                    title: Text(habit.name,
                        style: TextStyle(color: props.goal.color)),
                    subtitle: Text(habit.workRemaining()),
                    trailing: PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert),
                      onSelected: (String selected) {
                        if (selected == "delete") {
                          props.remove(habit);
                        } else if (selected == "edit") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddHabitPage(habit: habit)),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
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
                  margin: EdgeInsets.symmetric(vertical: 2),
                )
            ],
          ),
          Row(children: [
            Padding(padding: EdgeInsets.only(left: 10)),
            Icon(Icons.add, color: Colors.grey),
            Padding(padding: EdgeInsets.only(left: 10)),
            GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddHabitPage()),
                  );
                },
                child: Text(
                  "Add Habit",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ]),
        ]);
      },
    );
  }
}
