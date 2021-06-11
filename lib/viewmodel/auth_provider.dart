import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_message/model/Talks.dart';
import 'package:flutter_message/model/message.dart';
import 'package:flutter_message/model/repository.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/auth_base.dart';
import 'package:flutter_message/service/storage_base.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../locator.dart';

enum ViewState { Idle, Busy }

class AuthProvider with ChangeNotifier implements AuthBase, StorageBase {
  final _authRepository = locator<Repository>();
  ViewState _viewState = ViewState.Idle;
  Users _users;
  String mailError;
  String passwordError;

  Users get users => _users;

  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  ViewState get viewState => _viewState;

  AuthProvider() {
    CurrentUser();
  }

  @override
  Future<Users> AuthAnonim() async {
    try {
      viewState = ViewState.Busy;
      _users = await _authRepository.AuthAnonim();
      return _users;
    } catch (e) {
      return null;
    } finally {
      viewState = ViewState.Idle;
    }
  }

  @override
  Future<Users> CurrentUser() async {
    try {
      viewState = ViewState.Busy;
      _users = await _authRepository.CurrentUser();
      return Future.value(_users);
    } catch (e) {
      return null;
    } finally {
      viewState = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      viewState = ViewState.Busy;
      final _googleSign = GoogleSignIn();
      await _googleSign.signOut();
      bool result=await _authRepository.signOut();
      _users = null;
      print("user null oldu");
      return result;
    } finally {
      viewState = ViewState.Idle;
    }
  }

  @override
  Future<Users> AuthWithGoogle() async {
    try {
      viewState = ViewState.Busy;
      _users = await _authRepository.AuthWithGoogle();
      return _users;
    } finally {
      viewState = ViewState.Idle;
    }
  }

  @override
  Future<Users> AuthWithMail(String mail, String pass) async {
    if (checkUserandPass(mail, pass) == true) {
      try {
        viewState = ViewState.Busy;
        _users = await _authRepository.AuthWithMail(mail, pass);
        return _users;
      } finally {
        viewState = ViewState.Idle;
      }
    } else {
      return null;
    }
  }

  @override
  Future<Users> LoginWithMail(String mail, String pass) async {
    if (checkUserandPass(mail, pass) == true) {
      try {
        viewState = ViewState.Busy;
        _users = await _authRepository.LoginWithMail(mail, pass);
        return _users;
      } finally {
        viewState = ViewState.Idle;
      }
    } else {
      return null;
    }
  }

  bool checkUserandPass(String mail, String pass) {
    if (mail.contains('@') && pass.length >= 6) {
      return true;
    } else {
      if (!mail.contains('@')) {
        mailError = "Mail format isn't correct";
      } else {
        mailError = null;
      }
      if (pass.length <= 6) {
        passwordError = "Password can't be less 6 characters";
      } else {
        passwordError = null;
      }
    }
  }

  Future<bool> updateUsername(String userId, String username) async {
    return await _authRepository.updateUserName(username, userId);
  }

  @override
  Future<String> savePhoto(
      String userId, String fileType, PickedFile photo) async {
    return await _authRepository.savePhoto(userId, fileType, photo);
  }

  Future<bool> updatePhoto(String userId, String url) async {
     await _authRepository.updatePhoto(url, userId);
     return true;
  }

  Future<List<Users>> getAllUsers() async{
     var usersList=await _authRepository.getAllUsers();
    return usersList;
}
  Stream<List<Message>> getMessages (String currentUSerId,String talkUserId)  {
    var messageList=  _authRepository.getMessages(currentUSerId, talkUserId);
    return messageList;

  }
  Future<bool> saveMessage (Message message) async{
   try{
     await _authRepository.saveMessage(message);
     return Future.value(true);
   }finally{

   }
  }
  Future<List<Talks>> getAllTalks (String userId) async{
    try{
      return await _authRepository.getAllTalks(userId);
    }finally{
    }

}

}
