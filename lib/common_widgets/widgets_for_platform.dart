

import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class WidgetsForPlatform extends StatelessWidget{
    Widget androidPlatforms();
    Widget iosPlatforms();

    @override
    Widget build(BuildContext context) {
    if(Platform.isIOS){
      return iosPlatforms();
    }
    return androidPlatforms();
  }


}

