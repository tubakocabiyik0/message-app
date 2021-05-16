import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_message/common_widgets/widgets_for_platform.dart';

class MyAlertDialog extends WidgetsForPlatform {
  final String title;
  final String subtitle;
  final String buttonText;
  final Function pressed;

  MyAlertDialog(this.title, this.subtitle, this.buttonText, this.pressed);

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context, builder: (context) => this)
        : await showDialog(context: (context), builder: (context) => this);
  }

  @override
  Widget androidPlatforms() {
    return AlertDialog(
      title: Text(title),
      backgroundColor: Colors.grey.shade300,
      content: Text(subtitle),
      actions: [RaisedButton(onPressed: pressed, child: Text(buttonText))],
    );
  }

  @override
  Widget iosPlatforms() {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        CupertinoDialogAction(onPressed: pressed, child: Text(buttonText))
      ],
    );
  }
}
