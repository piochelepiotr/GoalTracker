import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

import 'quotes.dart';

class Quote extends StatefulWidget {
  @override
  _Quote createState() => _Quote();
}

String buildQuote(int index) {
  return "    ${quotes[index]["quote"]} - ${quotes[index]["person"]}";
}

class _Quote extends State<Quote> {
  final generator = Random();
  int quoteIndex = 0;

  @override
  void initState() {
    super.initState();
    quoteIndex = generator.nextInt(quotes.length);
    Timer.periodic(Duration(seconds: 10), (Timer t) {
      setState(() {
        quoteIndex = generator.nextInt(quotes.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
        height: 200,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/image.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 120, left: 20, right: 20),
          child: Text(buildQuote(quoteIndex),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic)),
        ),
      ))
    ]);
  }
}
