import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:unmei_fl/utils.dart';
import 'package:unmei_fl/widget/utils_widget.dart';

import '../theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var switchNotificationsBtn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ListView(
        children: <Widget>[
          pageHeader("Настройки", Colors.white),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: ThemeProvider.themeOf(context).data.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 15),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Включить уведомления",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Switch(
                        value: switchNotificationsBtn,
                        onChanged: (btn) {},
                        activeColor: Colors.red,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Выберите тему",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          themeBtn(appThemeData[ThemeConfig.light], "Светлая тема", Colors.grey),
                          themeBtn(appThemeData[ThemeConfig.dark], "Темная тема", Colors.black12),
                          themeBtn(appThemeData[ThemeConfig.blueDark], "Темно-синия тема", Colors.blue[900]),
                          themeBtn(appThemeData[ThemeConfig.redDark], "Темно-красная тема", Colors.red[900]),
                          themeBtn(appThemeData[ThemeConfig.greenDark], "Темно-зеленая тема", Colors.green[900]),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  themeBtn(ThemeData theme, String str, Color color) => GestureDetector(
        onTap: () {
          Get.changeTheme(theme);
          showToast(context, str, color, Icons.brightness_3);
        },
        child: CircleAvatar(
          radius: 25,
          child: Icon(
            Icons.brightness_6,
            color: Colors.white,
          ),
          backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
        ),
      );
}
