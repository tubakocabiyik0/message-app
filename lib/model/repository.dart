import 'dart:io';

import 'package:flutter_message/locator.dart';
import 'package:flutter_message/model/Talks.dart';
import 'package:flutter_message/model/message.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/AuthwithFirebase.dart';
import 'package:flutter_message/service/auth_base.dart';
import 'package:flutter_message/service/db_base.dart';
import 'package:flutter_message/service/fake_service.dart';
import 'package:flutter_message/service/firebaseStorage.dart';
import 'package:flutter_message/service/firestore.dart';
import 'package:flutter_message/service/storage_base.dart';
import 'package:image_picker/image_picker.dart';

enum AppMode { DEBUG, REALESE }

class Repository implements AuthBase, DbBase , StorageBase {
  AppMode _appMode = AppMode.REALESE;
  AuthWithFirebaseAuth _authWithFirebaseAuth = locator<AuthWithFirebaseAuth>();
  FakeService _fakeService = locator<FakeService>();
  FireStoreAdd _fireStoreAdd = locator<FireStoreAdd>();
  FirebaseStorageService _firebaseStorageService=locator<FirebaseStorageService>();
  var photo;
  List<Users> allUsers=[];
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
      Users user =await _authWithFirebaseAuth.CurrentUser();
      return takeUser(user.UserId);
    }
  }

  @override
  Future<bool> signOut() async  {
    if (_appMode == AppMode.DEBUG) {
      return _fakeService.signOut();
    } else if (_appMode == AppMode.REALESE) {
       await _authWithFirebaseAuth.signOut();
       return true;
    }
  }

  @override
  Future<Users> AuthWithGoogle() async {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      Users _user = await _authWithFirebaseAuth.AuthWithGoogle();
      _fireStoreAdd.saveUSer(_user);
      return await _fireStoreAdd.takeUser(_user.UserId);
    }
  }

  @override
  Future<Users> AuthWithMail(String mail, String pass) async {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      Users _users = await _authWithFirebaseAuth.AuthWithMail(mail, pass);
      await _fireStoreAdd.saveUSer(_users);
      return await _fireStoreAdd.takeUser(_users.UserId);
    }
  }

  @override
  Future<Users> LoginWithMail(String mail, String pass) async {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      Users _user = await _authWithFirebaseAuth.LoginWithMail(mail, pass);
      return await _fireStoreAdd.takeUser(_user.UserId);
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

  @override
  Future<Users> takeUser(String userID) {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      return _fireStoreAdd.takeUser(userID);
    }
  }

  @override
  Future<bool> updateUserName(String newUserName, String userId) {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      return _fireStoreAdd.updateUserName(newUserName, userId);
    }   
  }

  @override
  Future<String> savePhoto(String userId, String fileType, PickedFile photo) async{
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
    var newPhoto= await _firebaseStorageService.savePhoto(userId, fileType, photo);
    return newPhoto;
    }
  }

  @override
  Future<bool> updatePhoto(String photoUrl, String userId)async {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      var newPhoto= await _fireStoreAdd.updatePhoto(photoUrl, userId);
      return true;
    }
  }

  @override
  Future<List<Users>> getAllUsers() async{
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      allUsers= await _fireStoreAdd.getAllUsers();
      return allUsers;
    }

  }

  @override
  Stream<List<Message>> getMessages(String currentUSerId, String talkUserId) {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
           return _fireStoreAdd.getMessages(currentUSerId, talkUserId);

    }
  }

  @override
  Future<bool> saveMessage(Message message) {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      return _fireStoreAdd.saveMessage(message);

    }
  }

  @override
  Future<List<Talks>> getAllTalks(String userId) async{
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      var allTalks=await _fireStoreAdd.getAllTalks(userId);
      //bu k??sm?? her sefer internete gitmemek i??in yapt??k
      for(var talks in allTalks){
        var receiverUser= findUser(talks.receiver);
        if(receiverUser!=null){
          talks.userName= receiverUser.userName;
          talks.profilePhoto=receiverUser.profilPhoto;
        }else{
          var user = await _fireStoreAdd.takeUser(receiverUser.UserId);
          talks.userName= user.userName;
          talks.profilePhoto=user.profilPhoto;
        }

      }


      return allTalks;

    }
  }
  Users findUser(String UserId){
    for(int i=0;i<allUsers.length;i++){
      if(allUsers[i].UserId==UserId){
        return allUsers[i];
      }
    }

  }

  @override
  Future<List<Users>> getAllUsersWithPagination(Users lastUser, int userCount) {
    if (_appMode == AppMode.DEBUG) {
      return null;
    } else if (_appMode == AppMode.REALESE) {
      return _fireStoreAdd.getAllUsersWithPagination(lastUser, userCount);

    }

  }

  @override
  Future<DateTime> getTime(String userId) {
    // TODO: implement getTime
    throw UnimplementedError();
  }



}
