import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_message/model/repository.dart';
import 'package:flutter_message/model/user.dart';
import 'package:provider/provider.dart';

import '../locator.dart';

enum AllUsersViewState { Idle, Loaded, Busy, Error }

class AllUsersProvider with ChangeNotifier {
  final _authRepository = locator<Repository>();
  AllUsersViewState _state = AllUsersViewState.Idle;
  Users _lastUser;
  List<Users> _userList=[];
  List<Users> get userList => _userList;
  int UserCount=10;

  get state => null;

  set state(AllUsersViewState value) {
    _state = value;
    notifyListeners();
   }

  AllUsersProvider() {
    _userList=[];
    _lastUser=null;
    getUserWithPagination(_lastUser,UserCount);

  }



  void getUserWithPagination(Users lastUser, int userCount )async {
if(_userList.length>0){
  _lastUser=_userList.last;
}
    state=AllUsersViewState.Busy;
     _userList=  await _authRepository.getAllUsersWithPagination(lastUser, userCount);
   state=AllUsersViewState.Loaded;
  }

  Future<List<Users>> getNewUsers() {

    getUserWithPagination(_lastUser, UserCount);

  }

}
