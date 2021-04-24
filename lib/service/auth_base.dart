
import 'package:flutter_message/model/user.dart';

abstract class AuthBase {
  Future<Users> CurrentUser() {}

  Future<Users> AuthAnonim() {}

  Future<bool> signOut() {}

  Future<Users> AuthWithGoogle() {}

  Future<Users> AuthWithMail(String mail,String pass) {}
  Future<Users> LoginWithMail(String mail,String pass) {}
}
