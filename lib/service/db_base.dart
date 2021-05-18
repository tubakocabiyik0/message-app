import 'package:flutter/material.dart';
import 'package:flutter_message/model/user.dart';

abstract class DbBase {

  Future<bool> saveUSer(Users user);
  Future<Users> takeUser(String userID);
  Future<bool> updateUserName(String newUserName,String userId);
  Future<bool> updatePhoto(String photoUrl,String userId);
  Future<List<Users>> getAllUsers();
  Stream  getMessages(String currentUSerId,String talkUserId);
}
