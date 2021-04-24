
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/db_base.dart';

class FireStoreAdd implements DbBase {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUSer(Users user) async{
    try {
      await _firebaseFirestore.collection("users").doc(user.UserId).set(user.tomap());
      return Future.value(false);
    } catch (e) {
      return Future.value(false);
    }
  }
}
