import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String payload;

  SecondPage({
    @required this.payload,
    Key key,
  }) : super(key: key) {
    print("building second page");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Second page - Payload:',
                style: Theme.of(context).textTheme.title,
              ),
              const SizedBox(height: 8),
              Text(
                payload,
                style: Theme.of(context).textTheme.subtitle,
              ),
              const SizedBox(height: 8),
              RaisedButton(
                child: Text('Back'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
}
