import 'package:flutter/material.dart';
import 'package:hikayet/HikayetConstants.dart';

class Sawaal extends StatefulWidget {

  String sawaal, jawaab;

  Sawaal(String sawaal, String jawaab); //TODO: require sawaal

  @override
  State<StatefulWidget> createState() {
    return _SawaalState();
  }
}

BoxDecoration sawaalDecoration() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
  );
}

class _SawaalState extends State<Sawaal> {

  String _sawaal, _jawaab;

  @override
  void initState() {
    _sawaal = widget.sawaal;
    _jawaab = widget.jawaab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: sawaalDecoration(),
        margin: EdgeInsets.only(left: 20, right: 20, top: 13),
        child: buildContent(),
      ),
    );
  }

  Widget buildContent(){
    return Text(
      _sawaal,
      style: textPostStyle(context),
    );
  }

  TextStyle textPostStyle(context){
    return TextStyle(
      fontFamily: "Petrona",
      fontSize: 17,
      color: Color(HikayetConstants.of(context).textColorHex),
    );
  }
}