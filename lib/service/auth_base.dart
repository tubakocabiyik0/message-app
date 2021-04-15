
import 'package:flutter_message/model/user.dart';

abstract class AuthBase {
  Future<Users> CurrentUser() {}

  Future<Users> AuthAnonim() {}

  Future<bool> signOut() {}
}
