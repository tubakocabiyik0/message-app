import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_message/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
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

  /*Users userFromFirebase(User user) {
    if (user = null) return null;
    return Users(UserId: user.uid);
  }*/

  @override
  Future<Users> CurrentUser() async {
    User user = await _firebaseAuth.currentUser;
    return Future.value(Users(UserId: user.uid));
  }

  @override
  Future<Users> AuthWithGoogle() async {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      if (_googleUser != null) {
        GoogleSignInAuthentication _googleSignInAuthentication =
            await _googleUser.authentication;

        UserCredential _userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
                idToken: _googleSignInAuthentication.idToken,
                accessToken: _googleSignInAuthentication.accessToken));
        return (Users(UserId: _userCredential.user.uid,email: _userCredential.user.email));
      }
  }

  @override
  Future<Users> AuthWithMail(String mail, String pass) async {
         UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass);
      return (Users(UserId: userCredential.user.uid,email: userCredential.user.email));

  }

  @override
  Future<Users> LoginWithMail(String mail, String pass) async {
         UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: mail, password: pass);
      return (Users(UserId: userCredential.user.uid,email: userCredential.user.email));

  }
}
