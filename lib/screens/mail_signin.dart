import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/common_widgets/button_widget.dart';
import 'package:flutter_message/common_widgets/textformfield.dart';
import 'package:flutter_message/screens/home_page.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class SigninWithMail extends StatefulWidget {
  @override
  _SigninWithMailState createState() => _SigninWithMailState();
}

class _SigninWithMailState extends State<SigninWithMail> {
  var mailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);


    if(authProvider.users!=null){
      return HomePage(authProvider.users);
    }


  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.purple.shade200,
      title: Text("Flutter Message"),
      elevation: 0,
    ),
    backgroundColor: Colors.grey.shade200,
    body: authProvider.viewState==ViewState.Idle ? Container(
      child: SingleChildScrollView(
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(top:90.0,right: 8,left: 8),
              child: Textformfield(
                icon: Icon(Icons.message),
                labelText: "mail",
                obscureText: false,
                controller: mailController,
                errorText: authProvider.mailError,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0,right: 8,left: 8),
              child: Textformfield(

                icon: Icon(Icons.vpn_key_rounded),
                labelText: "password",
                obscureText: true,
                controller: passwordController,
                errorText: authProvider.passwordError,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:18.0,right: 40,left: 40),
              child: ButtonWidgets(buttonText: "Sign in",pressed:()=>login(context),color: Colors.purple.shade300,icon: Icon(Icons.keyboard_tab_rounded)),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,right: 40,left: 40),
              child: ButtonWidgets(buttonText: "Sign up",pressed:()=>logup(context),color: Colors.purple.shade300,icon: Icon(Icons.keyboard_tab_rounded)),
            ),
          ],
        ),
      ),
    ) : Center(child: CircularProgressIndicator(),),
  );


  }

  login(BuildContext context) async{
    final authProvider = Provider.of<AuthProvider>(context,listen: false);
    await authProvider.LoginWithMail(mailController.text, passwordController.text);
  }

  logup(BuildContext context)async {
    final authProvider = Provider.of<AuthProvider>(context,listen: false);
    await authProvider.AuthWithMail(mailController.text, passwordController.text);
  }
}
