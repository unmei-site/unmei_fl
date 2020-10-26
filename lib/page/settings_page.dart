import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/bloc/unmei_theme_bloc.dart';
import 'package:unmei_fl/main.dart';
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
              color: appThemeData[ThemeConfig.values[0]].primaryColor,
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
                          themeBtn(ThemeConfig.light),
                          themeBtn(ThemeConfig.dark),
                          themeBtn(ThemeConfig.blueDark),
                          themeBtn(ThemeConfig.greenDark),
                          themeBtn(ThemeConfig.redDark),
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

  themeBtn(ThemeConfig theme) => GestureDetector(
        onTap: () {
          BlocProvider.of<ThemeBloc>(context).add(
            ThemeChanged(theme: theme),
          );
        },
        child: CircleAvatar(radius: 25, child: Icon(Icons.brightness_6)),
      );
}
