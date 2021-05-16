import 'package:flutter/cupertino.dart';
import 'package:flutter_message/model/repository.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../locator.dart';

enum ViewState { Idle, Busy }

class AuthProvider with ChangeNotifier implements AuthBase {
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
      await _authRepository.signOut();
      _users = null;
    } catch (e) {} finally {
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

  Future<bool> updateUsername(String userId,String username) async {


       return await _authRepository.updateUserName(username, userId);

  }

}
