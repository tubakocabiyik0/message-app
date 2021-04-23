import 'package:flutter/cupertino.dart';
import 'package:flutter_message/model/repository.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/auth_base.dart';

import '../locator.dart';

enum ViewState { Idle, Busy }

class AuthProvider with ChangeNotifier implements AuthBase {
  final _authRepository = locator<Repository>();
  ViewState _viewState = ViewState.Idle;
  Users _users;

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

    return _users;
  }

  @override
  Future<bool> signOut() async {
    try {
      viewState = ViewState.Busy;
      await _authRepository.signOut();
      _users = null;
    } catch (e) {
    } finally {
      viewState = ViewState.Idle;
    }
  }
}
