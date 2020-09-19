import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';
import '../utils.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  var switchNotificationsBtn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: onThemeON(context, Color(0xFF1F1F1F), Colors.red),
      child: ListView(
        children: <Widget>[
          pageHeader("Настройки", onThemeON(context, Color(0xFF851313), Colors.white)),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: onThemeON(context, Color(0xFF121212), Colors.white),
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
                          "Включить темную тему",
                          style: TextStyle(fontSize: 18, color: onThemeON(context, Colors.white, Colors.black)),
                        ),
                      ),
                      Switch(
                        value: context.watch<DataApp>().changeThemeData,
                        onChanged: (btn) => context.read<DataApp>().onChangeTheme(btn),
                        activeColor: Colors.red,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Включить уведомления",
                          style: TextStyle(fontSize: 18, color: onThemeON(context, Colors.white, Colors.black)),
                        ),
                      ),
                      Switch(
                        value: switchNotificationsBtn,
                        onChanged: (btn) => onChangeBtn(btn),
                        activeColor: Colors.red,
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

  btnContainer(String text, bool value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Switch(
            value: value,
            onChanged: (btn) => onChangeBtn(btn),
            activeColor: Colors.red,
          )
        ],
      );

  onChangeBtn(bool btn) async {
    var sharedPref = await SharedPreferences.getInstance();
    setState(() {
      switchNotificationsBtn = btn;
    });
  }
}
