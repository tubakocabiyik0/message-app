import 'package:flutter_message/locator.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/AuthwithFirebase.dart';
import 'package:flutter_message/service/auth_base.dart';
import 'package:flutter_message/service/fake_service.dart';

enum AppMode { DEBUG, REALESE }

class Repository implements AuthBase {
  AppMode _appMode = AppMode.REALESE;
  AuthWithFirebaseAuth _authWithFirebaseAuth = locator<AuthWithFirebaseAuth>();
  FakeService _fakeService = locator<FakeService>();

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
  Future<Users> AuthWithGoogle() {
    if(_appMode==AppMode.DEBUG){
      return null;
    }else if(_appMode==AppMode.REALESE){
      return _authWithFirebaseAuth.AuthWithGoogle();
    }
  }
}
