import 'package:flutter/material.dart';
import 'dart:ui';

class OnBoardingWidget extends StatefulWidget {
  final GlobalKey key;
  final Widget child;
  OnBoardingWidget({@required GlobalKey key, @required this.child})
      : key = key,
        super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<OnBoardingWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed =
          widget.key.currentContext.findRenderObject();
      final positionRed = renderBoxRed.localToGlobal(Offset.zero);
      Navigator.of(context).push(TutorialOverlay(
          offsetX: positionRed.dx,
          offsetY: positionRed.dy,
          child: widget.child));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: widget.child,
    );
  }
}

class TutorialOverlay extends ModalRoute<void> {
  final double offsetX;
  final double offsetY;
  final Widget child;

  TutorialOverlay(
      {@required this.offsetX, @required this.offsetY, @required this.child});

  @override
  Duration get transitionDuration => Duration(milliseconds: 0);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: Stack(children: [
          Padding(
              padding: EdgeInsets.only(left: offsetX, top: offsetY),
              child: Align(
                alignment: Alignment.topLeft,
                child: child,
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                  child: Text(
                      "Welcome to the Goal Tracker application. Thanks to it, you can keep track of the actions and habits you need to take to achieve your goals! Let's start by adding a goal.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white)))),
        ]));
  }
}
