import 'package:flutter/material.dart';
import 'package:hikayet/ChotayMotayWidgets/HikayetPagesTitle.dart';
import 'package:hikayet/ChotayMotayWidgets/Post.dart';

class TaazaTaaza extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaazaTaazaState();
  }

}

class _TaazaTaazaState extends State<TaazaTaaza> {

  List<Post> items = [Post("This"), Post("is"), Post("another"), Post("approach"),
              Post("to"), Post("Social"), Post("Networking")];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 70),
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              HikayetPageTitle("Taaza Taaza"),
              Expanded(
                child: ListView.builder
                  (
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return items[index];
                    }
                ),
              )
            ],
          ),
        )
    );
  }

}