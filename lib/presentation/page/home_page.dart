import 'package:flutter/material.dart';

import 'package:unmei_fl/presentation/page/news_page.dart';
import 'package:unmei_fl/presentation/page/novel_page.dart';
import 'package:unmei_fl/presentation/page/settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(context, label: selectedItemParams()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: _navBarsItems(),
        selectedItemColor: Color(int.parse(selectedItemParams(choose: "color"))),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _buildScreens().elementAt(_selectedIndex),
    );
  }

  String selectedItemParams({String choose = "name"}) {
    String name = "";
    switch (_selectedIndex) {
      case 0: name = choose == "color" ? "0xFF3f85ff" : "Новости";
        break;
      case 1: name = choose == "color" ? "0xFFa338eb" : "Новеллы";
        break;
      case 2: name = choose == "color" ? "0xFFeb3838" : "Настройки";
        break;
    }
    return name;
  }

  List<Widget> _buildScreens() {
    return [
      NewsPage(),
      NovelsPage(),
      SettingsPage(),
    ];
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: ("Главная"),
        backgroundColor: Color(0xFF3f85ff),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.my_library_books),
        label: ("Новеллы"),
        backgroundColor: Color(0xFFa338eb),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: ("Настройки"),
        backgroundColor: Color(0xFFeb3838),
      ),
    ];
  }
}
