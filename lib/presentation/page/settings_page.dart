import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

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
          pageHeader("Настройки", context),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ),
                      Switch(
                        value: switchNotificationsBtn,
                        onChanged: (btn) {
                          setState(() {
                            switchNotificationsBtn = !switchNotificationsBtn;
                          });
                        },
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
}
