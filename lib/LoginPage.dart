import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import  'package:firebase_auth/firebase_auth.dart';
import 'AuthService.dart';
import 'utilities/Utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),    // <= NEW
                    Text(
                      'Login Information',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20.0),   // <= NEW
                    TextFormField(
                        onSaved: (value) => _email = value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Email Address")),
                    TextFormField(
                        onSaved: (value) => _password = value,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password")),
                    SizedBox(height: 20.0),  // <= NEW
                    RaisedButton(child: Text("LOGIN"), onPressed: () async {
                      // save the fields..
                      final form = _formKey.currentState;
                      form.save();
                      // Validate will return true if is valid, or false if invalid.
                      if (form.validate()) {
                        try {
                          AuthResult result =
                          await Provider.of<AuthService>(context).loginUser(_email, _password);
                          print(result);
                        } on AuthException catch (error) {
                          // handle the firebase specific error
                          return Utils.buildErrorDialog(context, error.message);
                        } on Exception catch (error) {
                          // gracefully handle anything else that might happen..
                          return Utils.buildErrorDialog(context, error.toString());
                        }
                      }
                    }),
                  ],
                ),
            ),
        ),
    );
  }


}

