import 'package:flutter/material.dart';
import 'package:hikayet/HikayetConstants.dart';

class Post extends StatefulWidget {

  var content;


  Post(this.content);

  @override
  State<StatefulWidget> createState() {
    return _PostState();
  }



}

BoxDecoration postDecoration() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
  );
}

TextStyle textPostStyle(context){
  return TextStyle(
    fontFamily: "Petrona",
    fontSize: 17,
    color: Color(HikayetConstants.of(context).textColorHex),
  );
}

buildContent(content, context) {
  if (content is String) {
    return Text(
      content,
      style: textPostStyle(context),
    );
  }
}

class _PostState extends State<Post> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: postDecoration(),
        margin: EdgeInsets.only(left: 20, right: 20, top: 13),
        child: buildContent(widget.content, context),
      ),
    );
  }

}