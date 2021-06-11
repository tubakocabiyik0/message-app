
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/custom_navigation/tab_items.dart';
import 'package:flutter_message/screens/home_page.dart';

class MyTabNavigation extends StatelessWidget {

  const MyTabNavigation({Key key, this.onselectedTab, this.currentTab, this.getPage, this.getGlobalKey}) : super(key: key);
  final ValueChanged<TabItems> onselectedTab;
  final TabItems currentTab;
  final Map<TabItems,Widget> getPage;
  final Map<TabItems,GlobalKey<NavigatorState>> getGlobalKey;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(tabBar: CupertinoTabBar(items: [
      _bottomNavigationBarItem(TabItems.users),
      _bottomNavigationBarItem(TabItems.talks),
      _bottomNavigationBarItem(TabItems.profile),


    ],
    onTap: (index)=>onselectedTab(TabItems.values[index]),
    ), tabBuilder: (context,index){
      final selectedPage = TabItems.values[index];

          return CupertinoTabView(
              navigatorKey: getGlobalKey[selectedPage],
              builder: (context)=>getPage[selectedPage]);
    });
  }

  BottomNavigationBarItem _bottomNavigationBarItem (TabItems tabItems){
    final currentUser =BottomTabItems.toMap[tabItems];

    return BottomNavigationBarItem(icon:currentUser.icon,label: currentUser.title );
  }
}
