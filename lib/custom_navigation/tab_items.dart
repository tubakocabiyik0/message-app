import 'package:flutter/material.dart';

enum TabItems {users,talks,profile}

class BottomTabItems{
  final String title;
  final Icon icon;

  BottomTabItems({this.title, this.icon});

 static Map<TabItems,BottomTabItems> toMap = {
    TabItems.users : BottomTabItems(title:"users",icon:Icon(Icons.supervised_user_circle)),
   TabItems.talks:BottomTabItems(title:"tslks",icon:Icon(Icons.chat)),
   TabItems.profile:BottomTabItems(title:"profile",icon:Icon(Icons.person)),



 };


}