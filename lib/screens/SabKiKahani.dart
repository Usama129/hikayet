import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';

class SabKiKahani extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SabKiKahaniState();
  }

}

class _SabKiKahaniState extends State<SabKiKahani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: HikayetPageTitle("Sab ki Kahani")
      ),
    );
  }

}