import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/db_base.dart';

class FireStoreAdd implements DbBase {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUSer(Users user) async {
    Map _userMap = user.tomap();
    _userMap['createdAt'] = FieldValue.serverTimestamp();

    try {
      await _firebaseFirestore
          .collection("users")
          .doc(user.UserId)
          .set(_userMap);
      DocumentSnapshot _readUser = await _firebaseFirestore.collection("users").doc(user.UserId).get();
      Map<String,dynamic> _map = _readUser.data();
      Users takeUser= Users.fromMap(_map);
      print("alınanuserrrr"+takeUser.toString());
      return Future.value(false);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<Users> takeUser(String userID) async{
    try{
      DocumentSnapshot _readUser = await _firebaseFirestore.collection("users").doc(userID).get();
      Map<String,dynamic> _map = _readUser.data();
      Users takeUser= Users.fromMap(_map);
      print("alınanuserrrr"+takeUser.toString());
      return takeUser;
    }catch(e){
      print(e.toString()+"hataaaaaaaaa");
    }

  }
}
