import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/custom_navigation/tab_items.dart';

import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/screens/profile_page.dart';
import 'package:flutter_message/screens/users_page.dart';

import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

import 'tab_navigation.dart';

class HomePage extends StatefulWidget {
  final Users _user;

  HomePage(this._user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItems _currentTab = TabItems.users;

  Map<TabItems, Widget> _currentPage() {
    return {
      TabItems.users: AllUsers(),
      TabItems.profile: Profile(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: MyTabNavigation(
          getPage: _currentPage(),
          onselectedTab: (selectedTab) {
            setState(() {
              _currentTab = selectedTab;
            });
          },
          currentTab: _currentTab),
    );
  }

  signout(BuildContext context) async {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    await _authProvider.signOut();
  }
}
