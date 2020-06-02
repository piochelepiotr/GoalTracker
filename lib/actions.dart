import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';

typedef void _Action(Task task);
typedef void _Focus(int index);

class _Props {
  Goal goal;
  int focusedAction;
  _Action remove;
  _Action editTask;
  _Action cross;
  _Focus focusAction;
  Color goalColor;

  _Props({
    this.goal,
    this.remove,
    this.cross,
    this.editTask,
    this.focusAction,
    this.focusedAction,
    this.goalColor,
  });
}

class ActionsList extends StatefulWidget {
  ActionsList();

  @override
  _ActionsList createState() => _ActionsList();
}

class _ActionsList extends State<ActionsList> {
  final TextEditingController newActionController = TextEditingController();
  // final FocusNode newActionFocus = FocusNode();
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
        focusAction: (int index) => {
          store.dispatch(FocusAction(index)),
        },
        focusedAction: store.state.focusedAction,
        goalColor: store.state.activeGoal().color,
      ),
      builder: (context, props) {
        List<Task> actions = props.goal.actions();
        return Column(children: [
          Row(children: [
            Padding(padding: EdgeInsets.only(left: 10)),
            Text("Actions", style: TextStyle(fontSize: 19)),
            Spacer(),
            Text(props.goal.tasksDone(),
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            Padding(padding: EdgeInsets.only(left: 10)),
          ]),
          Padding(padding: EdgeInsets.only(top: 5)),
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Column(
              children: () {
                List<Widget> elements = List<Widget>();
                actions.asMap().forEach(
                      (index, action) => elements.add(Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                        activeColor: props.goalColor,
                                        value: action.crossed,
                                        onChanged: (value) {
                                          props.cross(action);
                                        })),
                                Padding(padding: EdgeInsets.only(left: 10)),
                                action.crossed
                                    ? Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text(action.name,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    decoration: TextDecoration
                                                        .lineThrough))))
                                    : Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              maxLines: null,
                                              onTap: () {
                                                props.focusAction(index);
                                              },
                                              onSubmitted: (String value) {
                                                props.focusAction(null);
                                                props.editTask(action.copyWith(
                                                    name: value));
                                              },
                                              controller: action.controller,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                isDense: true,
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            ))),
                                GestureDetector(
                                  onTap: () {
                                    props.focusAction(null);
                                    props.remove(action);
                                  },
                                  child: Icon(Icons.clear, color: Colors.grey),
                                ),
                              ]))),
                    );
                elements.add(
                  Row(children: [
                    Icon(Icons.add, color: Colors.grey),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                        child: TextField(
                      onTap: () {
                        props.focusAction(-1);
                      },
                      controller: newActionController,
                      autofocus: props.focusedAction == -1,
                      onSubmitted: (String value) {
                        props.editTask(Task(
                            name: value,
                            controller: TextEditingController(text: value)));
                        newActionController.clear();
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Add Action",
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
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
