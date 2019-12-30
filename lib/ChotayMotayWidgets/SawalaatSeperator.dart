import 'package:flutter/material.dart';
import 'package:hikayet/HikayetConstants.dart';

class SawalaatSeparator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Color(HikayetConstants.of(context).inputColorHex),
      thickness: 13,
    );
  }
}