import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';
import 'package:hikayet/HikayetConstants.dart';

class ApasKiBaat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApasKiBaatState();
  }

}

class _ApasKiBaatState extends State<ApasKiBaat> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 70),
        child: Scaffold(
          backgroundColor: Color(HikayetConstants.of(context).backgroundColorHex),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              HikayetPageTitle("Apas ki Baatein"),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        )
    );
  }


}