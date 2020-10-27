import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:unmei_fl/page/account_page.dart';
import 'package:unmei_fl/page/news_page.dart';
import 'package:unmei_fl/page/settings_page.dart';

import '../page/novel_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // var _listPage = List<Widget>();
  var _controller = PersistentTabController(initialIndex: 0);
  var box = GetStorage();

  @override
  void initState() {
    // _listPage.add(NewsPage());
    // _listPage.add(NovelsPage());
    // _listPage.add(AccountPage());
    // _listPage.add(SettingsPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      screens: _buildScreens(),
      controller: _controller,
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style6,
      backgroundColor: Colors.white,
    );
  }

  List<Widget> _buildScreens() {
    return [
      NewsPage(),
      NovelsPage(),
      AccountPage(),
      SettingsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Главная"),
        activeColor: Colors.blue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.my_library_books),
        title: ("Новеллы"),
        activeColor: Colors.deepPurple,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Аккаунт"),
        activeColor: Colors.green,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Настройки"),
        activeColor: Colors.red,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }
}
