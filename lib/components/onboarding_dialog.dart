import 'package:flutter/material.dart';

class OnBoardingDialog extends StatefulWidget {
  final String title;
  final String content;
  final String dismissText;
  final bool show;
  final VoidCallback onDismiss;

  OnBoardingDialog(
      {@required this.title,
      @required this.content,
      @required this.dismissText,
      @required this.onDismiss,
      @required this.show});

  @override
  _OnBoardingDialog createState() => _OnBoardingDialog();
}

class _OnBoardingDialog extends State<OnBoardingDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.show) {
        _showOnBoardingDialog(context, widget.title, widget.content,
            widget.dismissText, widget.onDismiss);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<void> _showOnBoardingDialog(BuildContext context, String title,
    String content, String dismissText, VoidCallback onDismiss) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        elevation: 2,
        actions: [
          FlatButton(
            child: Text(dismissText),
            onPressed: Navigator.of(context).pop,
          ),
        ]),
  );
  onDismiss();
}
