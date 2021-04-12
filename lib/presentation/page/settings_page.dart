import 'package:flutter/material.dart';

import '../../utils.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text("Основные", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    settingLine(
                        label: "Включить уведомления",
                        icon: Icons.notifications,
                        onChanged: (st) {
                          setState(() {
                            switchNotificationsBtn = !switchNotificationsBtn;
                          });
                          showToast(context, "Еще не сделали 😢", Colors.red[900], Icons.cancel);
                        }),
                    settingLine(label: "Какой-то переключатель"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  settingLine({String label = "No label", IconData icon = Icons.cancel, ValueChanged<bool> onChanged}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Container(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
      Switch(
        value: switchNotificationsBtn,
        onChanged: onChanged,
        activeColor: Color(0xFFeb3838),
      ),
    ],
  );
}
