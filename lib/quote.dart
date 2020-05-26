import 'package:flutter/material.dart';

class Quote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/image.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 120, bottom: 40),
        child: Text(
            "    Failure is an option here. If you are not failing, you are not inovating fast enough - Elon Musk",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.italic)),
      ),
    );
  }
}
