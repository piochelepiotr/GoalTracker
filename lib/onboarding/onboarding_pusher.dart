import 'package:flutter/material.dart';

class OnBoardingPusher extends StatefulWidget {
  final bool show;
  final VoidCallback onInit;

  OnBoardingPusher({@required this.onInit, @required this.show});

  @override
  _OnBoardingPusher createState() => _OnBoardingPusher();
}

class _OnBoardingPusher extends State<OnBoardingPusher> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.show) {
        widget.onInit();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
