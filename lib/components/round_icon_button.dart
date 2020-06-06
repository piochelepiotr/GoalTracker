import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Color color;
  final Color secondaryColor;
  final VoidCallback onTap;
  final IconData icon;
  RoundIconButton({this.color, this.secondaryColor, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          splashColor: Colors.black, // inkwell color
          child: SizedBox(
              width: 35, height: 35, child: Icon(icon, color: secondaryColor)),
          onTap: onTap,
        ),
      ),
    );
  }
}
