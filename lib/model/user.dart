import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Users {
  // ignore: non_constant_identifier_names
  final String UserId;
  String email;
  String profilPhoto;
  String userName;
  DateTime createdAt;
  String level;

  Users({@required this.UserId, @required this.email});

  Map<String, dynamic> tomap() {
    return {
      "UserId": UserId,
      "email": email,
      "profilPhoto": profilPhoto ?? '',
      "userName": userName ??
          email.substring(0, email.indexOf('@')) + random().toString(),
      "createdAt": createdAt ?? '',
      "level": level ?? '',
    };
  }

  @override
  String toString() {
    return 'Users{UserId: $UserId, email: $email, profilPhoto: $profilPhoto, userName: $userName, createdAt: $createdAt, level: $level}';
  }

  Users.fromMap(Map<String, dynamic> map)
      :
        UserId= map['UserId'],
        email = map['email'],
        profilPhoto=map['profilPhoto'],
        userName=map['userName'],
        createdAt=(map['createdAt']).toDate(),
        level=map['level'];


  String random() {
    int random = Random().nextInt(99999);
    return random.toString();
  }
}
