import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:unmei_fl/presentation/page/account_page.dart';
import 'package:unmei_fl/presentation/page/news_page.dart';
import 'package:unmei_fl/presentation/page/novel_page.dart';
import 'package:unmei_fl/presentation/page/settings_page.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  var _controller = PersistentTabController(initialIndex: 0);
  final storage = FlutterSecureStorage();
  String token;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
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
