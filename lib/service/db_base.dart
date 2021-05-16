import 'package:flutter_message/model/user.dart';

abstract class DbBase {

  Future<bool> saveUSer(Users user);
  Future<Users> takeUser(String userID);
  Future<bool> updateUserName(String newUserName,String userId);


}
