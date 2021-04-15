import 'package:flutter/cupertino.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/screens/home_page.dart';
import 'package:flutter_message/screens/signin_page.dart';
import 'package:flutter_message/service/auth_base.dart';

class LandingPage extends StatefulWidget {
  AuthBase authBase;

  LandingPage(this.authBase);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  Users users;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    if(users==null){
      return SignInPage(authBase: widget.authBase);
    }
    else{
     return HomePage(widget.authBase,users);
    }


  }

  Future<Users> checkUser() async {
    users = await widget.authBase.CurrentUser();
    if (users != null) {
      return users;
    } else {
      return users;
    }
  }
}
