import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';

class SawaalJawaab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SawaalJawaabState();
  }

}

class _SawaalJawaabState extends State<SawaalJawaab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: HikayetPageTitle("Sawaal Jawaab"),
      ),
    );
  }

}