import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Talks {
  final String send;
  final String receiver;
  final bool isSeen;
  final Timestamp createDate;
  final String lastMessage;
  final Timestamp seenDate;
  String profilePhoto;
  String userName;

  Talks(
      {this.send,
      this.receiver,
      this.isSeen,
      this.createDate,
      this.lastMessage,
      this.seenDate});

  Map<String, dynamic> toMap() {
    return {
      "send": send,
      "receiver": receiver,
      "isSeen": isSeen,
      "lastMessage": lastMessage,
      // date boşsa firebase'in date ini kullanır
      "createDate": createDate ?? FieldValue.serverTimestamp(),
      "seenDate": seenDate
    };
  }

  Talks.fromMap(Map<String, dynamic> map)
      : send = map['send'],
        receiver = map['receiver'],
        isSeen = map['isSeen'],
        lastMessage = map['lastMessage'],
        createDate = map['createDate'],
        seenDate = map['seenDate'];
}
