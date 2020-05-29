import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/state.dart';
import 'redux/actions.dart';
import 'model/goal.dart';
import 'model/task.dart';
import 'editable_title.dart';
import 'bottom_bar.dart';

class _AddTaskProps {
  VoidCallback addTask;
  final Goal goal;
  _AddTaskProps({this.addTask, this.goal});
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _AddTaskProps>(
        converter: (store) {
          return _AddTaskProps(
            addTask: () =>
                {store.dispatch(AddTask(Task(name: _textController.text)))},
            goal: store.state.goals
                .firstWhere((goal) => goal.id == store.state.selectedGoalID),
          );
        },
        builder: (context, props) {
          return Column(children: [
            EditableTitle(
              textController: _textController,
              color: props.goal.color,
              hint: "Task Name",
            ),
            Spacer(),
            BottomBar(buttons: [
              Button(
                  label: "Cancel",
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              Button(
                  label: "Save",
                  onPressed: () {
                    props.addTask();
                    Navigator.pop(context);
                  })
            ]),
          ]);
        },
      ),
    );
  }
}

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}
