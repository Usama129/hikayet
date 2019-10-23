import 'package:flutter/material.dart';
import 'package:hikayet/screens/ApasKiBaat.dart';
import 'package:hikayet/utilities/Utils.dart';
import 'screens/MeriKahani.dart';
import 'screens/SabKiKahani.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'AuthService.dart';


class Hikayet extends StatefulWidget {

  final FirebaseUser currentUser;

  Hikayet(this.currentUser);

  @override
  _HikayetState createState() => _HikayetState();
}

class _HikayetState extends State<Hikayet> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(

        bottomNavigationBar: TabBar(
          labelColor: Colors.blueAccent,
          tabs: [
            Tab(icon: Icon(Icons.people)),
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.chat_bubble_outline)),
          ],
        ),
        body: TabBarView(
          children: [
            SabKiKahani(),
            MeriKahani(),
            ApasKiBaat(),
          ],
        ),
            drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
            child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("Name of main character"),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  // Update the state of the app
                  logout();
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  logout() async {
    try {
      AuthResult result =
          await Provider.of<AuthService>(context).logout();
      print(result);
    } on AuthException catch (error) {
      // handle the firebase specific error
      return Utils.buildErrorDialog(context, error.message);
    } on Exception catch (error) {
      // gracefully handle anything else that might happen..
      return Utils.buildErrorDialog(context, error.toString());
    }
  }

}