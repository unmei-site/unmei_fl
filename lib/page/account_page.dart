import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unmei_fl/widget/utils_widget.dart';

import 'package:http/http.dart' as http;

import '../utils.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    var sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.getString("token") != null)
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => UserAccount()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.green,
              child: ListView(
                children: <Widget>[
                  pageHeader("Аккаунт", Colors.white),
                  accBody(),
                ],
              ),
            ),
    );
  }

  accBody() => Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "Авторизация",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.green,
                  width: 2,
                ),
              ),
              child: Column(
                children: <Widget>[
                  //INPUT
                  textInput("Логин", false, Icons.account_box, loginController),
                  textInput("Пароль", true, Icons.lock, passwordController),

                  //BUTTON
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 10, left: 40, right: 40, top: 10),
                    height: 40,
                    width: double.infinity,
                    child: SizedBox(
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(
                                loginController.text, passwordController.text);
                          },
                          color: Colors.white,
                          child: Text(
                            "Войти",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FlatButton(
                              onPressed: () {
                                launchURL("https://unmei.space/");
                              },
                              color: Colors.white,
                              child: Text(
                                "Регистрация",
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              launchURL("https://unmei.space/restore");
                            },
                            icon: Icon(
                              Icons.lock_open,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //SOCIAL CONTAINER
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  accSocialIcon(
                      "https://vk.com/unmei_site",
                      "assets/icons/vk.svg",
                      0xFF597da3,
                      const EdgeInsets.only(right: 5)),
                  accSocialIcon(
                      "https://t.me/unmei_site",
                      "assets/icons/telegram.svg",
                      0xFF0088cc,
                      const EdgeInsets.only(right: 5)),
                  accSocialIcon("https://discord.gg/4CA8Cju",
                      "assets/icons/discord.svg", 0xFF7289DA, null),
                ],
              ),
            ),
          ],
        ),
      );

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  signIn(String login, String password) async {
    var sharedPref = await SharedPreferences.getInstance();
    var data = {
      'login': login,
      'password': password,
    };

    var resp = await http.post(
        "https://api.unmei.space/v1/auth/login?auth_type=token",
        body: jsonEncode(data));
    if (resp.statusCode == 200) {
      var request = jsonDecode(resp.body);
      sharedPref.setString('token', request['data']);
      showToast(context, "Добро пожаловать!", Colors.green, Icons.check);

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => UserAccount()));
    } else {
      setState(() {
        _isLoading = false;
      });
      print(resp.body);
    }
  }

  textInput(String text, bool hideText, IconData icon,
          TextEditingController controller) =>
      Container(
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        height: 40,
        width: double.infinity,
        child: TextFormField(
          obscureText: hideText,
          controller: controller,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black54),
            hintText: text,
            hintStyle: TextStyle(color: Colors.black54),
            border: InputBorder.none,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      );

  accSocialIcon(String url, String icon, int color, EdgeInsets edge) =>
      GestureDetector(
        onTap: () {
          launchURL(url);
        },
        child: Container(
          margin: edge,
          child: CircleAvatar(
            backgroundColor: Color(color),
            child: SvgPicture.asset(icon),
          ),
        ),
      );
}

class UserAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: ListView(
          children: <Widget>[
            pageHeader("Аккаунт", Colors.white),
            accBody(context),
          ],
        ),
      ),
    );
  }

  accBody(context) => Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text("A"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Username",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: GestureDetector(
                                onTap: () => onLogout(context),
                                child: Icon(
                                  Icons.exit_to_app,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.blue)),
                          child: Text(
                            "Stuff",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    flagIcon("0", Icons.assistant_photo, 0xFF399999),
                    flagIcon("0", Icons.check, 0xFF339933),
                    flagIcon("0", Icons.av_timer, 0xFF993399),
                    flagIcon("0", Icons.ac_unit, 0xFF51d4ff),
                    flagIcon("0", Icons.not_interested, 0xFF993333),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  flagIcon(String n, IconData icon, int color) => Column(
        children: [
          Icon(icon, size: 40, color: Color(color)),
          Text(n, style: TextStyle(fontSize: 22)),
        ],
      );

  onLogout(context) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove("token");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AccountPage()));
    showToast(context, "Возвращайтесь!", Colors.amber, Icons.next_plan);
    print("Success exited!");
  }
}
