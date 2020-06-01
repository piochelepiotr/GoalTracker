import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';
import 'add_habit_page.dart';

typedef void _Action(Task task);
typedef void _Focus(int index);

class _Props {
  Goal goal;
  int focusedHabit;
  _Action remove;
  _Action editTask;
  _Action cross;
  _Focus focusHabit;

  _Props(
      {this.goal,
      this.remove,
      this.cross,
      this.editTask,
      this.focusHabit,
      this.focusedHabit});
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
        remove: (Task task) => {
          store.dispatch(RemoveTask(task)),
        },
        cross: (Task task) => {
          store.dispatch(CrossTask(task)),
        },
        editTask: (Task task) => {
          store.dispatch(AddTask(task)),
        },
        focusHabit: (int index) => {
          store.dispatch(FocusHabit(index)),
        },
        focusedHabit: store.state.focusedHabit,
      ),
      builder: (context, props) {
        List<Task> habits = props.goal.habits();
        return Column(children: [
          Row(children: [
            Padding(padding: EdgeInsets.only(left: 10)),
            Text("Habits", style: TextStyle(fontSize: 19)),
            Spacer(),
          ]),
          Padding(padding: EdgeInsets.only(top: 5)),
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Column(
              children: () {
                List<Widget> elements = List<Widget>();
                habits.asMap().forEach(
                      (index, habit) => elements.add(Row(children: [
                        SizedBox(
                            height: 30,
                            width: 24,
                            child: Checkbox(
                                value: habit.crossed,
                                onChanged: (value) {
                                  props.cross(habit);
                                })),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Expanded(
                            child: TextFormField(
                          onTap: () {
                            props.focusHabit(index);
                          },
                          onFieldSubmitted: (String value) {
                            props.focusHabit(null);
                            props.editTask(habit.copyWith(name: value));
                          },
                          initialValue: habit.name,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        )),
                        SizedBox(
                            height: 24,
                            width: 24,
                            child: IconButton(
                                icon: Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  props.focusHabit(null);
                                  props.remove(habit);
                                })),
                      ])),
                    );
                elements.add(
                  Row(children: [
                    Icon(Icons.add, color: Colors.grey),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    GestureDetector(
                        onTap: () {
                          props.focusHabit(null);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddHabitPage()),
                          );
                        },
                        child: Text(
                          "Add Habit",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )),
                  ]),
                );
                return elements;
              }(),
            ),
          ),
        ]);
      },
    );
  }
}
