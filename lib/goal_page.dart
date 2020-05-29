import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'create_task_page.dart';
import 'add_habit_page.dart';
import 'create_goal_page.dart';
import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';
import 'bottom_bar.dart';

typedef void _Action(Task task);
typedef void _SetWork(int workDone);

class _GoalProps {
  Goal goal;
  _Action remove;
  _Action editTask;
  _Action cross;
  VoidCallback incrWork;
  VoidCallback decrWork;
  _SetWork setWork;
  _GoalProps(
      {this.goal,
      this.remove,
      this.cross,
      this.incrWork,
      this.decrWork,
      this.setWork,
      this.editTask});
}

class _GoalPage extends State<GoalPage> {
  Task focusedAction;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _GoalProps>(
        converter: (store) => _GoalProps(
              goal: store.state.goals
                  .firstWhere((goal) => goal.id == store.state.selectedGoalID),
              remove: (Task task) => {
                store.dispatch(RemoveTask(task)),
              },
              cross: (Task task) => {
                store.dispatch(CrossTask(task)),
              },
              incrWork: () => {
                store.dispatch(IncrWork()),
              },
              decrWork: () => {
                store.dispatch(DecrWork()),
              },
              setWork: (int workDone) => {
                store.dispatch(SetWork(workDone)),
              },
              editTask: (Task task) => {
                store.dispatch(AddTask(task)),
              },
            ),
        builder: (context, goalProps) {
          Color color = goalProps.goal.color;
          List<Task> actions = goalProps.goal.actions();
          List<Task> habits = goalProps.goal.habits();
          TextEditingController newActionController = TextEditingController();
          Map<int, TextEditingController> actionControllers = Map.fromIterable(
            actions,
            key: (action) => action.id,
            value: (action) => TextEditingController(text: action.name),
          );
          return Scaffold(
            body: Column(children: [
              Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(children: [
                        Row(children: [
                          Expanded(
                              child: Container(
                            decoration:
                                BoxDecoration(color: goalProps.goal.color),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 50, bottom: 5),
                              child: Column(children: [
                                Row(children: [
                                  Text(goalProps.goal.name,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  Spacer(),
                                  ClipOval(
                                    child: Material(
                                      color: color, // button color
                                      child: InkWell(
                                        splashColor:
                                            Colors.black, // inkwell color
                                        child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Icon(Icons.edit,
                                                color: Colors.white)),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateGoalPage(
                                                        goal: goalProps.goal)),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                                Padding(padding: EdgeInsets.only(bottom: 20)),
                                Row(children: [
                                  Text(goalProps.goal.workString(),
                                      style: TextStyle(color: Colors.grey)),
                                  Spacer(),
                                  ClipOval(
                                    child: Material(
                                      color: Colors.white, // button color
                                      child: InkWell(
                                        splashColor:
                                            Colors.black, // inkwell color
                                        child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Icon(Icons.remove)),
                                        onTap: () {
                                          goalProps.decrWork();
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      child: TextField(
                                        controller: TextEditingController()
                                          ..text = goalProps.goal.workDone
                                              .toString(),
                                        onChanged: (String value) {
                                          try {
                                            int workDone = int.parse(value);
                                            goalProps.setWork(workDone);
                                          } on FormatException {}
                                        },
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ClipOval(
                                    child: Material(
                                      color: Colors.white, // button color
                                      child: InkWell(
                                        splashColor:
                                            Colors.black, // inkwell color
                                        child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Icon(Icons.add)),
                                        onTap: () {
                                          goalProps.incrWork();
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                              ]),
                            ),
                          ))
                        ]),
                        LinearProgressIndicator(
                            value: goalProps.goal.progress(),
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 255 - color.red,
                                    255 - color.green, 255 - color.blue)),
                            backgroundColor: goalProps.goal.color),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(children: [
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text("Actions", style: TextStyle(fontSize: 19)),
                          Spacer(),
                          Text(goalProps.goal.tasksDone(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                          Padding(padding: EdgeInsets.only(left: 10)),
                        ]),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Padding(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            children: actions
                                .map(
                                  (action) => Row(children: [
                                    SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Checkbox(
                                            value: action.crossed,
                                            onChanged: (value) {
                                              goalProps.cross(action);
                                            })),
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    Expanded(
                                        child: FocusScope(
                                            child: Focus(
                                                onFocusChange: (focus) {
                                                  if (focus) {
                                                    setState(() {
                                                      focusedAction = action;
                                                    });
                                                  }
                                                },
                                                child: TextField(
                                                  onSubmitted: (String value) {
                                                    goalProps.editTask(
                                                        focusedAction.copyWith(
                                                            name: value));
                                                    setState(() {
                                                      focusedAction = null;
                                                    });
                                                  },
                                                  controller: actionControllers[
                                                      action.id],
                                                  cursorColor: Colors.black,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                )))),
                                    (focusedAction != null &&
                                            focusedAction.id == action.id)
                                        ? IconButton(
                                            icon: Icon(Icons.clear,
                                                color: Colors.grey),
                                            onPressed: () {
                                              goalProps.remove(action);
                                            })
                                        : Container(),
                                  ]),
                                )
                                .toList()
                                  ..add(
                                    Row(children: [
                                      Icon(Icons.add, color: Colors.grey),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Expanded(
                                          child: FocusScope(
                                              child: Focus(
                                                  onFocusChange: (focus) {
                                                    if (focus) {
                                                      setState(() {
                                                        focusedAction = Task();
                                                      });
                                                    }
                                                  },
                                                  child: TextField(
                                                    onSubmitted:
                                                        (String value) {
                                                      goalProps.editTask(
                                                          focusedAction
                                                              .copyWith(
                                                                  name: value));
                                                      setState(() {
                                                        focusedAction = null;
                                                      });
                                                    },
                                                    controller:
                                                        newActionController,
                                                    cursorColor: Colors.black,
                                                    decoration: InputDecoration(
                                                      hintText: "Add Action",
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      isDense: true,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                    ),
                                                  )))),
                                    ]),
                                  ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Row(children: [
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text("Habits", style: TextStyle(fontSize: 19)),
                          Padding(padding: EdgeInsets.only(left: 5)),
                          ClipOval(
                            child: Material(
                              color: Colors.grey, // button color
                              child: InkWell(
                                splashColor: Colors.white, // inkwell color
                                child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child:
                                        Icon(Icons.add, color: Colors.white)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddHabitPage()),
                                  );
                                },
                              ),
                            ),
                          ),
                          Spacer(),
                        ]),
                        Padding(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                              children: habits
                                  .map(
                                    (habit) => Row(children: [
                                      Checkbox(
                                          value: habit.crossed,
                                          onChanged: (value) {
                                            goalProps.cross(habit);
                                          }),
                                      Expanded(
                                          child: TextField(
                                        controller: TextEditingController(
                                            text: habit.name),
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
                                    ]),
                                  )
                                  .toList()),
                        ),
                      ]))),
              focusedAction != null
                  ? BottomBar(
                      buttons: [
                        Button(
                          label: "Cancel",
                          onPressed: () {
                            actionControllers[focusedAction.id].text =
                                "DEADBEEF";
                            setState(() {
                              focusedAction = null;
                            });
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                        ),
                        Button(
                          label: "Save",
                          onPressed: () {
                            String name;
                            if (focusedAction.id == null) {
                              name = newActionController.text;
                            } else {
                              name = actionControllers[focusedAction.id].text;
                            }
                            goalProps
                                .editTask(focusedAction.copyWith(name: name));
                            setState(() {
                              focusedAction = null;
                            });
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                        ),
                      ],
                    )
                  : BottomBar(
                      buttons: [
                        Button(
                          label: "Home",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
            ]),
          );
        });
  }
}

class GoalPage extends StatefulWidget {
  GoalPage();

  @override
  _GoalPage createState() => _GoalPage();
}
