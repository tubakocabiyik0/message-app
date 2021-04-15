
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/button_widgets/button_widget.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/AuthwithFirebase.dart';
import 'package:flutter_message/service/auth_base.dart';

class SignInPage extends StatelessWidget{
  AuthBase authBase;

  SignInPage({ @required this.authBase});


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Flutter Message"),
       elevation: 0,
     ),
     backgroundColor: Colors.grey.shade200,
     body: Padding(
       padding: const EdgeInsets.only(top:108),
       child: Column(
         children: [
           Center(child: Text("Sign in",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),)),
           ButtonWidgets("Sign with email & password",signWithMail,Colors.redAccent.shade100,Icon(Icons.mail_outline_sharp)),
           ButtonWidgets("Sign with google account",signWithGoogle,Colors.white,Icon(Icons.create)),
           ButtonWidgets("Signin anonim",signin,Colors.green,Icon(Icons.details_rounded)),
         ],
       ),
     ) ,
   );
  }


  signWithMail() {

   //Navigator.push( context,MaterialPageRoute(builder:(context)=>SigninWithMail()));

  }

  signWithGoogle() {

  }

   signin() async{
   await authBase.AuthAnonim();
   Users users =await authBase.CurrentUser();
   print(users.UserId);
  }
}