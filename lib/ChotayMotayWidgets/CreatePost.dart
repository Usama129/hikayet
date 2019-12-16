import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikayet/Hikayet.dart';
import 'package:hikayet/HikayetConstants.dart';


class CreatePost extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CreatePostState();
  }
}

class _CreatePostState extends State<CreatePost>{

  final postTextController = TextEditingController();
  FirebaseUser _currentUser;

  bool _enlarged = false;

  FocusNode _focusNode;
  double _height;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    postTextController.dispose();
    super.dispose();
  }

  @override
  initState() {
    _focusNode = FocusNode();
    _focusNode.addListener((){
      //widget.enlargeOrReduceInputBox();
      changeEnlargedInputState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (_enlarged)
       _height = 150;
    else
       _height = 50;

    final Hikayet hikayet = context.ancestorWidgetOfExactType(Hikayet);
    final HikayetState hikayetState = hikayet?.state;

    _currentUser = hikayetState?.currentUser;

    return GestureDetector(

      child: Container(
          decoration: new BoxDecoration(
            color: Color(HikayetConstants.of(context).inputColorHex),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: _height,
          margin: EdgeInsets.only(left: 20, right: 20, top: 13),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: TextField(
                    controller: postTextController,
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w300),
                    focusNode: _focusNode,
                    autocorrect: false,
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "What's up?",
                      focusColor: Colors.white,
                    )
                ),
              ),
              _enlarged?
              Align(
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.min, // this will take space as minimum as posible(to center)
                  children: <Widget>[

                    RaisedButton(
                      child: new Text('Send'),
                      onPressed: (){
                        sendNormTextPost(postTextController.text);
                        postTextController.clear();
                      },
                      color: Color(HikayetConstants.of(context).buttonsColorHex),
                    ),
                  ],
                ),
              )
                  : Container(),
            ],
          )
      ),
    );

  }

  changeEnlargedInputState(){
    setState(() {
      _enlarged = !_enlarged;
    });
  }

  sendNormTextPost(String text) async {


    if (text.isEmpty)
      return showAlertDialog(context);
    int time = DateTime.now().millisecondsSinceEpoch;
    await Firestore.instance.collection("main")
        .document(time.toString())
        .setData({
      'norm_text': text,
      'time': time,
      'user': _currentUser.email,
    });

  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget dismissBtn = FlatButton(
      child: Text("OK"),
      onPressed:  () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text("Aray kuch tou likhiye!"),
      actions: [
        dismissBtn
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}