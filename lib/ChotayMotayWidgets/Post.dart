import 'package:flutter/material.dart';

class Post extends StatefulWidget {

  var content;


  Post(this.content);

  @override
  State<StatefulWidget> createState() {
    return _PostState();
  }



}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide( //                    <--- top side
        color: Colors.grey,
        width: 0.5,
      ),
    ),
  );
}

TextStyle textPostStyle(){
  return TextStyle(
    fontFamily: "Petrona",
    fontSize: 17,
  );
}

buildContent(content) {
  if (content is String) {
    return Text(
      content,
      style: textPostStyle(),
    );
  }
}

class _PostState extends State<Post> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: myBoxDecoration(),
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: buildContent(widget.content),
        ),
      ),
    );
  }

}