import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final Users _user;

  HomePage(this._user);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        title: Text("Message App"),
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RaisedButton(
                onPressed: () async{
                  signout(context);
                },
                child: Text("Log out")),
          )),
        ],
      ),
      body: Center(child: Text(_user.UserId)),
    );
  }

   signout(BuildContext context)async {
     final _authProvider = Provider.of<AuthProvider>(context,listen: false);
    await _authProvider.signOut();
   }
}
