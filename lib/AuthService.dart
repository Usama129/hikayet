import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //var currentUser;

  AuthService() {
    print("new AuthService");
  }

  Future<FirebaseUser> getUser() {
    //return Future.value(currentUser);
    return _auth.currentUser();
  }

  // wrapping the firebase calls
  Future logout() async {
    /*this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);*/

    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }

  // wrapping the firebase calls
  Future createUser(
      {String firstName,
        String lastName,
        String email,
        String password}) async {}

  // logs in the user if password matches
  Future<AuthResult> loginUser(String email, String password) async {
  /*  if (password == 'password123') {
      this.currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }*/

    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // since something changed, let's notify the listeners...
      notifyListeners();
      return result;
    }  catch (e) {
      // throw the Firebase AuthException that we caught
      throw new AuthException(e.code, e.message);
    }
  }
}