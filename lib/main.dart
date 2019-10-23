import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'Hikayet.dart';
import 'AuthService.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider<AuthService>(
    child: MyApp(),
    builder: (BuildContext context) {
      return AuthService();
    },
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder(
        // get the Provider, and call the getUser method
        future: Provider.of<AuthService>(context).getUser(),
        // wait for the future to resolve and render the appropriate
        // widget for HomePage or LoginPage
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }

            return snapshot.hasData ? Hikayet(snapshot.data) : LoginPage();
          } else {
            return LoadingCircle();
          }
        },
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}

