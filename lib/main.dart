import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/screens/landing_service.dart';
import 'package:flutter_message/screens/signin_page.dart';
import 'package:flutter_message/service/AuthwithFirebase.dart';
import 'package:flutter_message/service/auth_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Message App',
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
      home: LandingPage(AuthWithFirebaseAuth()),
    );
  }
}
