
import 'package:flutter_message/model/user.dart';

import 'auth_base.dart';

class FakeService implements AuthBase {
  @override
  Future<Users> AuthAnonim() {
    return Future.value(Users(UserId:"1231231231"));
  }

  @override
  Future<Users> CurrentUser() {
    return Future.value(Users(UserId:"123123123"));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<Users> AuthWithGoogle() {
    // TODO: implement AuthWithGoogle
    throw UnimplementedError();
  }
}
