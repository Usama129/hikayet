import 'package:flutter/material.dart';
import 'package:hikayet/HikayetConstants.dart';
import 'package:hikayet/screens/ApasKiBaat.dart';
import 'package:hikayet/screens/MeriKahani.dart';
import 'package:hikayet/screens/SawaalJawaab.dart';
import 'package:hikayet/utilities/Utils.dart';
import 'screens/TaazaTaaza.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'AuthService.dart';


class Hikayet extends StatefulWidget {

  final FirebaseUser currentUser;

  Hikayet(this.currentUser);

  HikayetState state;

  @override
  HikayetState createState(){
    state = HikayetState();
    return state;
  }
}

class HikayetState extends State<Hikayet> {

  FirebaseUser _currentUser;

  FirebaseUser get currentUser => _currentUser;
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _currentUser = widget.currentUser;
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(HikayetConstants.of(context).backgroundColorHex),
        floatingActionButton: Align(
          alignment: Alignment(-0.8,-0.65),
          child: FloatingActionButton(
            foregroundColor: Color(HikayetConstants.of(context).buttonsColorHex),
            backgroundColor: Colors.transparent,
            onPressed: () => setState(() => _drawerKey.currentState.openDrawer()),
            tooltip: 'Mein',
            child: const Icon(Icons.account_circle),
            heroTag: null,
          ),
        ),
        bottomNavigationBar: TabBar(
          labelColor: Color(HikayetConstants.of(context).buttonsColorHex),
          tabs: [
            Tab(icon: Icon(Icons.import_contacts)),
            Tab(icon: Icon(Icons.short_text)),
            Tab(icon: Icon(Icons.chat_bubble_outline)),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child:  TabBarView(
                children: <Widget>[
                  TaazaTaaza(),
                  SawaalJawaab(_currentUser),
                  ApasKiBaat(),
                ],
              ),
            ),
          ],
        ),
            key: _drawerKey,
            drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
            child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MeriKahani(_currentUser)),
                        );
                      },
                      tooltip: 'Meri Kahani',
                      child: const Icon(Icons.person),
                      heroTag: null,
                    ),
                    Text(widget.currentUser.email)
                  ],
                ),
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