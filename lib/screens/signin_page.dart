import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/common_widgets/button_widget.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';
import 'mail_signin.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
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
            ButtonWidgets(
                buttonText: "Sign with email & password",
                pressed: () => signWithMail(context),
                color: Colors.redAccent.shade100,
                icon: Icon(Icons.mail_outline_sharp)),
            ButtonWidgets(
              buttonText: "Sign with google account",
              pressed: () => signWithGoogle(context),
              color: Colors.white,
              icon: Icon(Icons.create),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                onPressed: () async {
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

  signWithMail(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(

        builder: (context) => SigninWithMail()));
  }

  signWithGoogle(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.AuthWithGoogle();
  }
}
