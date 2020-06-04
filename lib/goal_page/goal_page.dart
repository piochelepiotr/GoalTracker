import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/state.dart';
import '../redux/actions.dart';
import '../components/bottom_bar.dart';
import 'actions.dart';
import 'habits.dart';
import 'header.dart';

typedef void _Focus(int index);

class _Props {
  final bool focused;
  _Focus focusAction;
  _Props({
    this.focused,
    this.focusAction,
  });
}

class _GoalPage extends State<GoalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(children: [
                  GoalPageHeader(),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  ActionsList(),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  HabitsList(),
                ]))),
        StoreConnector<AppState, _Props>(
          converter: (store) => _Props(
            focused: store.state.focusedAction != null ||
                store.state.focusedHabit != null,
            focusAction: (int index) => {
              store.dispatch(FocusAction(index)),
            },
          ),
          builder: (context, props) {
            return BottomBar(
              buttons: props.focused
                  ? [
                      Button(
                        label: "Cancel",
                        onPressed: () {
                          props.focusAction(null);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                      ),
                    ]
                  : [
                      Button(
                        label: "Home",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
            );
          },
        ),
      ]),
    );
  }
}

class GoalPage extends StatefulWidget {
  GoalPage();

  @override
  _GoalPage createState() => _GoalPage();
}
