import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';

class MeriKahani extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MeriKahaniState();
  }

}

class _MeriKahaniState extends State<MeriKahani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: HikayetPageTitle("Meri Kahani")
      ),
    );
  }

}