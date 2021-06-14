import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_message/model/Talks.dart';
import 'package:flutter_message/model/message.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/service/db_base.dart';

class FireStoreAdd implements DbBase {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Users> allUserList=[];
  @override
  Future<bool> saveUSer(Users user) async {
    Map _userMap = user.tomap();
    _userMap['createdAt'] = FieldValue.serverTimestamp();

    try {
      await _firebaseFirestore
          .collection("users")
          .doc(user.UserId)
          .set(_userMap);
      DocumentSnapshot _readUser =
          await _firebaseFirestore.collection("users").doc(user.UserId).get();
      Map<String, dynamic> _map = _readUser.data();
      Users takeUser = Users.fromMap(_map);
      print("alınanuserrrr" + takeUser.toString());
      return Future.value(false);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<Users> takeUser(String userID) async {
    try {
      DocumentSnapshot _readUser =
          await _firebaseFirestore.collection("users").doc(userID).get();
      Map<String, dynamic> _map = _readUser.data();
      Users takeUser = Users.fromMap(_map);
      return takeUser;
    } catch (e) {}
  }

  @override
  Future<bool> updateUserName(String newUserName, String userId) async {
    var user = await _firebaseFirestore
        .collection("users")
        .where("userName", isEqualTo: newUserName)
        .get();
    if (user.size > 0) {
      return false;
    } else {
      await _firebaseFirestore
          .collection("users")
          .doc(userId)
          .update({'userName': newUserName});
      return true;
    }
  }

  @override
  Future<bool> updatePhoto(String photoUrl, String userId) async {
    await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .update({'profilPhoto': photoUrl});
  }

  @override
  Future<List<Users>> getAllUsers() async {
    QuerySnapshot querySnapshot =
        await _firebaseFirestore.collection("users").get();
    /*for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
      print(documentSnapshot.data().toString());

    }*/

    allUserList = querySnapshot.docs
        .map((document) => Users.fromMap(document.data()))
        .toList();
    return allUserList;
  }

  @override
  Stream<List<Message>> getMessages(String currentUSerId, String talkUserId) {
    var snapshot = _firebaseFirestore
        .collection("talks")
        .doc(currentUSerId + "--" + talkUserId)
        .collection("messages")
        .orderBy("date", descending: true)
        .snapshots();
    //snapshot'da collection'dan aldığımız verileri message classından frommap function'ını kullanarak message türüne dönüştürdük ve to list diyerek listeledik
    // iki tane map işlemi yaptık

    var list = snapshot.map((messages) => messages.docs
        .map((message) => Message.fromMap(message.data()))
        .toList());
    return list;
  }

  @override
  Future<bool> saveMessage(Message message) async {
    //firebase rastgele bir document oludtursun dedik ve id'sini aldık.
    // bunu messajı eklerken kullanacağız
    var messageId = _firebaseFirestore.collection("messages").doc().id;

    var myDocumentId = message.sendMessage + "--" + message.takeMessage;
    var receiverDocumentId = message.takeMessage + "--" + message.sendMessage;

    await _firebaseFirestore
        .collection("talks")
        .doc(myDocumentId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
    await _firebaseFirestore.collection("talks").doc(myDocumentId).set({
      "lastMessage": message.message,
      "receiver": message.takeMessage,
      "send": message.sendMessage,
      "createDate": FieldValue.serverTimestamp(),
      "isSeen": false
    });

    var map = message.toMap();
    map.update("fromMe", (value) => false);
    await _firebaseFirestore
        .collection("talks")
        .doc(receiverDocumentId)
        .collection("messages")
        .doc(messageId)
        .set(map);

    try {
      await _firebaseFirestore.collection("talks").doc(receiverDocumentId).set({
        "lastMessage": message.message,
        "receiver": message.sendMessage,
        "send": message.takeMessage,
        "createDate": FieldValue.serverTimestamp(),
        "isSeen": false
      });
    } catch (e) {
      print("hata burada:" + e.toString());
    }
    ;
    return true;
  }

  @override
  Future<List<Talks>> getAllTalks(String userId) async {
    var querySnapshot = await _firebaseFirestore
        .collection("talks")
        .where("send", isEqualTo: userId)
        .get();
    List<Talks> allTalks = [];

    for (DocumentSnapshot talkInfo in querySnapshot.docs) {
      Talks talk = Talks.fromMap(talkInfo.data());
      allTalks.add(talk);
    }
    return allTalks;
  }

  @override
  Future<List<Users>> getAllUsersWithPagination(Users lastUser, int userCount) async{
    QuerySnapshot querySnapshot;
    // hasmore burada kontrol edilebilir
    List<Users> allUsers=[];
    if (lastUser == null) {
      querySnapshot =
          await FirebaseFirestore.instance.collection("users").orderBy("userName")
          .limit(userCount)
          .get();
    } else {
      querySnapshot =
          await FirebaseFirestore.instance.collection("users").orderBy("userName")
          .startAfter([lastUser.userName]).limit(userCount)
          .get();
    }
    /* if (querySnapshot.docs.length < userCount) {
      _hasMore = false;
    }*/

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {

      allUsers.add(Users.fromMap(documentSnapshot.data()));
    }
    return allUsers;
  }

  @override
  Future<DateTime> getTime(String userId)  async{
    await _firebaseFirestore.collection("server").doc(userId).set({
      "time":FieldValue.serverTimestamp(),
    });
    var documentSnapshot =await _firebaseFirestore.collection("server").doc(userId).get();
    Timestamp time= documentSnapshot.data()["time"];

    return time.toDate();
  }
  }

