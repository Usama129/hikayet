import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';

class ApasKiBaat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApasKiBaatState();
  }

}

class _ApasKiBaatState extends State<ApasKiBaat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: HikayetPageTitle("Apas ki Baatein")
      ),
    );
  }


}