import 'dart:async';
import 'package:flutter/material.dart';

class Refresher extends StatefulWidget {
  final VoidCallback refresh;
  Refresher({this.refresh});
  @override
  _Refresher createState() => _Refresher();
}

class _Refresher extends State<Refresher> {
  Timer update;

  @override
  void initState() {
    super.initState();
    update = Timer.periodic(Duration(seconds: 30), (timer) {
      widget.refresh();
    });
  }

  @override
  void dispose() {
    update.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
