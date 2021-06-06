import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/screens/home_page.dart';

import 'package:flutter_message/screens/signin_page.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.viewState == ViewState.Idle) {
      if (authProvider.users == null) {
        print("buraya geldi");
        return SignInPage();
      } else if(authProvider.users !=null) {
         print(authProvider.CurrentUser());
         //return Text("homepage dönecek");
        return HomePage(authProvider.users);
      }
    } else if (authProvider.viewState == ViewState.Busy) {
      return Center(
        child:CircularProgressIndicator(),
      );
    }

  }

}
