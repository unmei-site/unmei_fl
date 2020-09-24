import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:unmei_fl/page/account_page.dart';
import 'package:unmei_fl/page/news_page.dart';
import 'package:unmei_fl/page/settings_page.dart';

import '../page/novel_page.dart';
import '../utils.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var _pageIndex = 0;
  var _listPage = List<Widget>();

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
    // final tabs = [
    //   NewsPage(),
    //   NovelsPage(),
    //   AccountPage(),
    //   SettingsPage(),
    // ];
    return CustomScaffold(
      scaffold: Scaffold(
        // body: tabs[_pageIndex],
        body: IndexedStack(
          children: _listPage,
          index: _pageIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Новости"),
                backgroundColor: onThemeON(context, Color(0xFF1F1F1F), Colors.blue)),
            BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Text("Новеллы"),
                backgroundColor: onThemeON(context, Color(0xFF1F1F1F), Colors.deepPurple)),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text("Аккаунт"),
                backgroundColor: onThemeON(context, Color(0xFF1F1F1F), Colors.green)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text("Настройки"),
                backgroundColor: onThemeON(context, Color(0xFF1F1F1F), Colors.red)),
          ],
        ),
      ),
      children: _listPage,
      onItemTap: (index) {
        setState(() {
          _pageIndex = index;
        });
      },
    );
  }
}
