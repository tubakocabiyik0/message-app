import 'package:flutter/material.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(onPressed: ()=>signout(context), child: Icon(Icons.exit_to_app,size: 35,)),
        ],
        backgroundColor: Colors.purple.shade300,
        title: Text("Profile Page"),
      ),
      body: Container(),
    );
  }
  signout(BuildContext context) async {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    await _authProvider.signOut();
  }
}
