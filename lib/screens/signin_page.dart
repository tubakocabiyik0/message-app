
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/button_widgets/button_widget.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';


class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final authProvider= Provider.of<AuthProvider>(context,listen:false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Message"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.only(top: 108),
        child: Column(
          children: [
            Center(
                child: Text(
              "Sign in",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            )),
            ButtonWidgets("Sign with email & password", signWithMail,
                Colors.redAccent.shade100, Icon(Icons.mail_outline_sharp)),
            ButtonWidgets("Sign with google account", signWithGoogle,
                Colors.white, Icon(Icons.create)),
      Padding(
        padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          onPressed: ()async{
            await authProvider.AuthAnonim();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.person),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Text("Sign in Anonim"),
                ),
              ),
            ],
          ),
          color: Colors.greenAccent,
          elevation: 0,
        ),
      )
          ],
        ),
      ),
    );
  }

  signWithMail() {
    //Navigator.push( context,MaterialPageRoute(builder:(context)=>SigninWithMail()));
  }

  signWithGoogle() {}


}
