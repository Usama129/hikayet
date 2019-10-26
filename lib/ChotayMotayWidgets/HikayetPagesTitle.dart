import 'package:flutter/material.dart';

class HikayetPageTitle extends StatelessWidget {
  HikayetPageTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.85),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          fontFamily: 'B612',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}