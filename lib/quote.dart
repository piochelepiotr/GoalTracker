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
  Timer timer;

  void setTimer() {
    timer = Timer.periodic(Duration(seconds: 20), (Timer t) {
      setState(() {
        quoteIndex = generator.nextInt(quotes.length);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    quoteIndex = generator.nextInt(quotes.length);
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: GestureDetector(
              onTap: () {
                setState(() {
                  quoteIndex = generator.nextInt(quotes.length);
                  timer.cancel();
                  setTimer();
                });
              },
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
              )))
    ]);
  }
}
