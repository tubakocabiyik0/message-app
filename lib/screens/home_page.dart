import 'package:flutter/cupertino.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/auth_base.dart';

class HomePage extends StatelessWidget{
  AuthBase authBase;

  HomePage(this.authBase, this._user);
  final Users _user;
  @override
  Widget build(BuildContext context) {

    return Text(_user.UserId);
  }


}