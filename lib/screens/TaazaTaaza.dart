import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/CreatePost.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';
import 'package:hikayet/ChotayMotayWidgets/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikayet/HikayetConstants.dart';

class TaazaTaaza extends StatefulWidget {

  TaazaTaazaState state;

  @override
  State<StatefulWidget> createState() {
    state = TaazaTaazaState();
    return state;
  }
}

class TaazaTaazaState extends State<TaazaTaaza> {

  final databaseReference = Firestore?.instance;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
          padding: EdgeInsets.only(top: 70),
          child: Scaffold(
            backgroundColor: Color(HikayetConstants.of(context).backgroundColorHex),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HikayetPageTitle("Taaza Taaza"),
                Expanded(
                  child: getPostStream(),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget getPostStream()  {

    return StreamBuilder(
      stream: databaseReference.collection("main").snapshots(),
      builder: (BuildContext  context, AsyncSnapshot snapshot)
      {
        if (snapshot.hasData) {
          return new ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length + 1,
                padding: const EdgeInsets.only(top: 5.0),
                itemBuilder: (context, index) {
                  if (index == 0)
                    return new CreatePost();
                  DocumentSnapshot ds = snapshot.data.documents[index - 1];
                  return new Post(ds.data["norm_text"]);
                }
          );
        }
        return new CircularProgressIndicator();
      },
    );
  }

}