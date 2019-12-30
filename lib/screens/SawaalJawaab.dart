import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';
import 'package:hikayet/ChotayMotayWidgets/Sawaal.dart';
import 'package:hikayet/ChotayMotayWidgets/SawalaatSeperator.dart';
import 'package:hikayet/HikayetConstants.dart';
import 'package:hikayet/ChotayMotayWidgets/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SawaalJawaab extends StatefulWidget {

  final FirebaseUser currentUser;

  SawaalJawaab(this.currentUser);

  @override
  State<StatefulWidget> createState() {
    return _SawaalJawaabState();
  }

}

class _SawaalJawaabState extends State<SawaalJawaab> {

  final databaseReference = Firestore?.instance;

  int _nayeSawaalCount, _puranaySawaalCount;
  bool _nayeSawaalExpanded, _puranaySawaalExpanded;

  double _nayeSawaalHeight;

  FirebaseUser _currentUser;

  @override
  void initState() {
    super.initState();
    _nayeSawaalHeight = 400;
    _nayeSawaalExpanded = false;
    _puranaySawaalExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    _currentUser = widget.currentUser;
    return Padding(
        padding: EdgeInsets.only(top: 70),
        child: Scaffold(
          backgroundColor: Color(HikayetConstants.of(context).backgroundColorHex),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              HikayetPageTitle("Sawaal Jawaab"),
              _puranaySawaalExpanded ? Container() :
              _nayeSawaalExpanded ? Expanded(child: getNayeSawaalStream()) : Container(child: getNayeSawaalStream(), height: _nayeSawaalHeight),
              //showSeparator() ? SawalaatSeparator() : Container(),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: (d){
                  setState(() {
                    _puranaySawaalExpanded = false;
                    _nayeSawaalExpanded = false;
                  });
                },
                onVerticalDragUpdate: (d) {
                  setHeightNayeSawaal(d.globalPosition.dy);
                },
                onVerticalDragEnd: (d){
                  expandCollapseNayeSawaal(d);
                },
                child: SawalaatSeparator(),
              ),
              _nayeSawaalExpanded ? Container() : Expanded( child: getPuranaySawaalStream() ),
            ],
          ),
        )
    );
  }

  Widget getNayeSawaalStream() {

    return Scaffold(
      backgroundColor: Color(HikayetConstants.of(context).backgroundColorHex),
      body: StreamBuilder(
        stream: databaseReference.collection('userdata').document(_currentUser.email)
            .collection('sawalaat').where('jawaab', isNull: true)
            .snapshots(),
        builder: (BuildContext  context, AsyncSnapshot snapshot)
        {
          if (snapshot.hasData) {
            _nayeSawaalCount = snapshot.data.documents.length;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: _nayeSawaalCount,
                padding: const EdgeInsets.only(top: 5.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Sawaal(ds.data["sawaal"], "");
                }
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }


  Widget getPuranaySawaalStream() {

    return Scaffold(
      backgroundColor: Color(HikayetConstants.of(context).backgroundColorHex),
      body: StreamBuilder(
        stream: databaseReference.collection('userdata').document(_currentUser.email)
            .collection('sawalaat').where('jawaab', isGreaterThan: "")
            .snapshots(),
        builder: (BuildContext  context, AsyncSnapshot snapshot)
        {
          if (snapshot.hasData) {
            _puranaySawaalCount = snapshot.data.documents.length;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: _puranaySawaalCount,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return new Post(ds.data["sawaal"]);
                }
            );
          }
          return new CircularProgressIndicator();
        },
      ),
    );
  }

 /* expandContractList(String listName){
    if (listName == "naye"){
      setState(() {
        _nayeSawaalExpanded = !_nayeSawaalExpanded;
      });
    }
    else if(listName == "puranay"){
      setState(() {
        _puranaySawaalExpanded = !_puranaySawaalExpanded;
      });
    }
  }*/

  bool showSeparator(){
    if (_nayeSawaalCount == 0 || _puranaySawaalCount == 0)
      return false;
    if (_nayeSawaalExpanded || _puranaySawaalExpanded)
      return false;
    return true;
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(HikayetConstants.of(context).inputColorHex),
          width: 13,
        ),
      ),
    );
  }
  
  setHeightNayeSawaal(double dy){
    setState(() {
      _nayeSawaalHeight = dy - 100 >= 0 && dy - 100 <= 520 ? // unreliable
      dy - 100
          : _nayeSawaalHeight;
      // TODO: Why does it work correctly with -100?
    });
  }

  expandCollapseNayeSawaal(DragEndDetails d){
    //debugPrint(deets.primaryVelocity.toString());
    // TODO: Review, self-devised
    if (d.primaryVelocity.abs() > 700) {
      if (d.velocity.pixelsPerSecond.dy < 0)
        setState(() {
          _puranaySawaalExpanded = true;
          _nayeSawaalExpanded = false;
        });
      if (d.velocity.pixelsPerSecond.dy >= 0)
        setState(() {
          _nayeSawaalExpanded = true;
          _puranaySawaalExpanded = false;
        });
    }
  }
}