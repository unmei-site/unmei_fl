import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

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
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: GestureDetector(
              onTap: () => showToast(context, "Входить в аккаунт пока нельзя 😧", Colors.red[900], Icons.cancel),
              child: SvgPicture.asset("assets/icons/user.svg"),
            ),
          ),
        ),
        title: Text("Настройки", style: TextStyle(fontSize: 32, color: Colors.black)),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
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
                      showToast(context, "Еще не сделали 😢", Colors.red[900], Icons.cancel);
                    },
                    activeColor: Color(0xFFeb3838),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
