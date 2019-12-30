import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';
import 'package:hikayet/ChotayMotayWidgets/Post.dart';
import 'package:hikayet/HikayetConstants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeriKahani extends StatefulWidget {

  final FirebaseUser currentUser;

  MeriKahani(this.currentUser);

  @override
  State<StatefulWidget> createState() {
    return _MeriKahaniState();
  }

}

class _MeriKahaniState extends State<MeriKahani> {

  final databaseReference = Firestore?.instance;
  FirebaseUser _currentUser;

  @override
  Widget build(BuildContext context) {
    _currentUser = widget.currentUser;
    return Scaffold(
      backgroundColor: Color(HikayetConstants.of(context).backgroundColorHex),
      floatingActionButton: Align(
        alignment: Alignment(-0.8,-0.8),
        child: FloatingActionButton(
          foregroundColor: Color(HikayetConstants.of(context).buttonsColorHex),
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          tooltip: 'More',
          child: const Icon(Icons.home),
          heroTag: null,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 70),
          child: Scaffold(
            backgroundColor: Color(HikayetConstants.of(context).backgroundColorHex),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HikayetPageTitle("Meri Kahani"),
                Expanded(
                  child: getPostStream(),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget getPostStream() {

    return StreamBuilder(
      stream: databaseReference.collection('main').where('user', isEqualTo: _currentUser.email)
          .snapshots(),
      builder: (BuildContext  context, AsyncSnapshot snapshot)
      {
        if (snapshot.hasData) {
          return new ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 5.0),
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return new Post(ds.data["norm_text"]);
              }
          );
        }
        return new CircularProgressIndicator();
      },
    );
  }
}