import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_message/model/user.dart';

import 'auth_base.dart';

class AuthWithFirebaseAuth implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<Users> AuthAnonim() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();

      return Future.value(Users(UserId: userCredential.user.uid));
    } catch (e) {
      return null;
    }
  }

  Users userFromFirebase(User user) {
    if(user=null)
      return null;
      return Users(UserId: user.uid);
    }

  @override
  Future<Users> CurrentUser() async {
    User user = await _firebaseAuth.currentUser;
    return Future.value(Users(UserId: user.uid));
  }
}
