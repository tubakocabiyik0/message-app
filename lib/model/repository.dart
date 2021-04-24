import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_message/locator.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/AuthwithFirebase.dart';
import 'package:flutter_message/service/auth_base.dart';
import 'package:flutter_message/service/db_base.dart';
import 'package:flutter_message/service/fake_service.dart';
import 'package:flutter_message/service/firestore.dart';

enum AppMode { DEBUG, REALESE }

class Repository implements AuthBase, DbBase {
  AppMode _appMode = AppMode.REALESE;
  AuthWithFirebaseAuth _authWithFirebaseAuth = locator<AuthWithFirebaseAuth>();
  FakeService _fakeService = locator<FakeService>();
  FireStoreAdd _fireStoreAdd = locator<FireStoreAdd>();

  @override
  Future<Users> AuthAnonim() async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeService.AuthAnonim();
    } else if (_appMode == AppMode.REALESE) {
      return await _authWithFirebaseAuth.AuthAnonim();
    }
  }

  @override
  Future<Users> CurrentUser() async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeService.CurrentUser();
    } else if (_appMode == AppMode.REALESE) {
      return await _authWithFirebaseAuth.CurrentUser();
    }
  }

  @override
  Future<bool> signOut() {
    if (_appMode == AppMode.DEBUG) {
      return _fakeService.signOut();
    } else if (_appMode == AppMode.REALESE) {
      return _authWithFirebaseAuth.signOut();
    }
  }

  @override
  Future<Users> AuthWithGoogle()async {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      Users _user= await _authWithFirebaseAuth.AuthWithGoogle();
      _fireStoreAdd.saveUSer(_user);
      return _user;
    }
  }

  @override
  Future<Users> AuthWithMail(String mail, String pass) async {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      Users _users = await _authWithFirebaseAuth.AuthWithMail(mail, pass);
      _fireStoreAdd.saveUSer(_users);
      return _users;
    }
  }

  @override
  Future<Users> LoginWithMail(String mail, String pass) async {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      Users _user = await _authWithFirebaseAuth.LoginWithMail(mail, pass);
      return _user;
    }
  }

  @override
  Future<bool> saveUSer(Users user) {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      return _fireStoreAdd.saveUSer(user);
    }
  }
}
