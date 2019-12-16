import 'package:flutter/material.dart';
import 'package:hikayet/HikayetConstants.dart';

class HikayetPageTitle extends StatelessWidget {
  HikayetPageTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      //decoration: myBoxDecoration(),
      child:  Align(
        alignment: Alignment(0, -0.85),
        child: Text(
          text,
          style: TextStyle(
            color: Color(HikayetConstants.of(context).titleColorHex),
            fontSize: 22,
            fontFamily: 'B612',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}