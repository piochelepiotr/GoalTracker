import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/state.dart';
import '../redux/actions.dart';
import '../model/goal.dart';
import '../model/action.dart';
import 'text_edit.dart';

class _Props {
  Goal goal;
  int focusedAction;
  Function(ActionModel) remove;
  Function(ActionModel) editAction;
  Function(ActionModel) addAction;
  Function(ActionModel) cross;
  Function(int) focusAction;
  Color goalColor;

  _Props({
    this.goal,
    this.remove,
    this.cross,
    this.editAction,
    this.addAction,
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
        remove: (ActionModel action) => {
          store.dispatch(DeleteAction(action)),
        },
        cross: (ActionModel action) => {
          store.dispatch(CrossAction(action)),
        },
        editAction: (ActionModel action) => {
          store.dispatch(EditAction(action)),
        },
        addAction: (ActionModel action) => {
          store.dispatch(AddAction(action)),
        },
        focusAction: (int index) => {
          store.dispatch(FocusAction(index)),
        },
        focusedAction: store.state.focusedAction,
        goalColor: store.state.activeGoal().color,
      ),
      builder: (context, props) {
        List<ActionModel> actions = props.goal.actions;
        return Column(children: [
          Row(children: [
            Padding(padding: EdgeInsets.only(left: 10)),
            Text("Actions", style: TextStyle(fontSize: 19)),
            Spacer(),
            Text(props.goal.actionsDone(),
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
                                    : TextEdit(
                                        onFocus: () {
                                          props.focusAction(index);
                                        },
                                        onSubmitted: (String value) {
                                          props.focusAction(null);
                                          props.editAction(
                                              action.copyWith(name: value));
                                        },
                                        controller: action.controller,
                                      ),
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
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.add, color: Colors.grey),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    TextEdit(
                      hint: 'Add Action',
                      onFocus: () {
                        props.focusAction(-1);
                      },
                      onEditingComplete: () {},
                      onSubmitted: (String value) {
                        props.addAction(ActionModel(name: value));
                        newActionController.clear();
                      },
                      controller: newActionController,
                    ),
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
