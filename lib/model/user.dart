import 'package:flutter/cupertino.dart';

class Users {

  // ignore: non_constant_identifier_names
  final String UserId;

  Users({@required this.UserId});

  Map<String, dynamic> tomap() {
    return {
      "UserId": UserId,

    };
  }

}