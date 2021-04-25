import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Users {
  // ignore: non_constant_identifier_names
  final String UserId;
  String email;
  String profilPhoto;
  String userName;
  DateTime createdAt;
  int level;

  Users({@required this.UserId, @required this.email});

  Map<String, dynamic> tomap() {
    return {
      "UserId": UserId,
      "email": email,
      "profilPhoto": profilPhoto ?? '',
      "userName": userName ?? '',
      "createdAt": createdAt ?? '',
      "level": level ?? '',
    };
  }

  Users fromMap(Map<String, dynamic> map) {
    map['UserId'] = this.UserId;
    map['email'] = this.email;
    map['profilPhoto'] = this.profilPhoto;
    map['userName'] = this.userName;
    map['createdAt'] = this.createdAt;
    map['level'] = this.level;
  }
}
