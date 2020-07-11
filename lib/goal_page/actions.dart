import 'package:flutter/material.dart';
import '../model/goal.dart';
import '../model/action.dart';
import '../analytics/analytics.dart';

class ActionsList extends StatefulWidget {
  final Goal goal;
  final Function(ActionModel) remove;
  final Function(ActionModel) editAction;
  final Function(ActionModel) addAction;
  final Function(ActionModel) cross;
  ActionsList({
    @required this.goal,
    @required this.remove,
    @required this.editAction,
    @required this.addAction,
    @required this.cross,
  });

  @override
  _ActionsList createState() => _ActionsList();
}

class _ActionsList extends State<ActionsList> {
  void addAction(String name) {
    sendAnalyticsEvent("addAction");
    widget.addAction(ActionModel(name: name));
    newActionController.clear();
  }

  FocusNode newActionFocusNode;
  final TextEditingController newActionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    newActionFocusNode = FocusNode();
    newActionFocusNode.addListener(() {
      if (!newActionFocusNode.hasFocus) {
        String newAction = newActionController.text;
        newActionController.clear();
        if (newAction != "") {
          addAction(newAction);
        }
      }
    });
  }

  @override
  void dispose() {
    newActionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ActionModel> actions = widget.goal.actions;
    return Column(children: [
      Row(children: [
        Padding(padding: EdgeInsets.only(left: 10)),
        Text("Actions", style: TextStyle(fontSize: 19)),
        Spacer(),
        Text(widget.goal.actionsDone(),
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
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 35,
                                width: 35,
                                child: Checkbox(
                                    activeColor: widget.goal.color,
                                    value: action.crossed,
                                    onChanged: (value) {
                                      widget.cross(action);
                                    })),
                            Padding(padding: EdgeInsets.only(left: 5)),
                            action.crossed
                                ? Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 6),
                                        child: Text(action.name,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                decoration: TextDecoration
                                                    .lineThrough))))
                                : Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 6),
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          maxLines: null,
                                          onSubmitted: (String value) {
                                            widget.editAction(
                                                action.copyWith(name: value));
                                          },
                                          controller: action.controller,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(0),
                                            isDense: true,
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ))),
                            GestureDetector(
                              onTap: () {
                                widget.remove(action);
                              },
                              child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(Icons.clear, color: Colors.grey)),
                            ),
                          ]))),
                );
            elements.add(
              GestureDetector(
                  onTap: () {
                    newActionFocusNode.requestFocus();
                  },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Icon(Icons.add, color: Colors.grey),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: TextField(
                                  focusNode: newActionFocusNode,
                                  keyboardType: TextInputType.text,
                                  maxLines: null,
                                  onEditingComplete: () {},
                                  onSubmitted: (String value) {
                                    addAction(value);
                                  },
                                  controller: newActionController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: 'Add Action',
                                    contentPadding: EdgeInsets.all(0),
                                    isDense: true,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                )))
                      ])),
            );
            return elements;
          }(),
        ),
      ),
    ]);
  }
}
