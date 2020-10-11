import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:unmei_fl/page/account_page.dart';
import 'package:unmei_fl/page/news_page.dart';
import 'package:unmei_fl/page/settings_page.dart';
import 'package:unmei_fl/widget/utils_widget.dart';

import '../page/novel_page.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var _listPage = List<Widget>();
  var _controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    _listPage.add(NewsPage());
    _listPage.add(NovelsPage());
    _listPage.add(AccountPage());
    _listPage.add(SettingsPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      screens: _listPage,
      controller: _controller,
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style6,
      backgroundColor: onThemeON(context, Color(0xFF1F1F1F), Colors.white),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Главная"),
        activeColor: onThemeON(context, Colors.white, Colors.blue),
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.book),
        title: ("Новеллы"),
        activeColor: onThemeON(context, Colors.white, Colors.deepPurple),
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Аккаунт"),
        activeColor: onThemeON(context, Colors.white, Colors.green),
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Настройки"),
        activeColor: onThemeON(context, Colors.white, Colors.red),
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }
}
