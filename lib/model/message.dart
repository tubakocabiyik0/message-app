import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String sendMessage;
  bool fromMe;
  String takeMessage;
  String message;
  DateTime date;

  Message(
      {this.sendMessage,
      this.fromMe,
      this.takeMessage,
      this.message,
      this.date});

  Map<String, dynamic> toMap() {
    return {
      "sendMessage": sendMessage,
      "fromMe": fromMe,
      "takeMessage": takeMessage,
      "message": message,
      // date boşsa firebase'in date ini kullanır
      "date": date ?? FieldValue.serverTimestamp(),
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : sendMessage = map['sendMessage'],
        fromMe = map['fromMe'],
        takeMessage = map['takeMessage'],
        message = map['message'],
        date = map['date'];
}
