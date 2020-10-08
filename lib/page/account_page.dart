import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';
import '../utils.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isLoading = false;

  @override
  void initState() {
    // checkLogin();
    super.initState();
  }

  // checkLogin() async {
  //   var sharedPref = await SharedPreferences.getInstance();
  //   if (sharedPref.getString("token") != null) Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserAccount()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: onThemeON(context, Color(0xFF1f1f1f), Colors.green),
              child: ListView(
                children: <Widget>[
                  pageHeader("Аккаунт", onThemeON(context, Color(0xFF1f6b22), Colors.white)),
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
          color: onThemeON(context, Color(0xFF121212), Colors.white),
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
                  color: onThemeON(context, Colors.white, Colors.black),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
              decoration: BoxDecoration(
                color: onThemeON(context, null, Colors.green[100]),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: onThemeON(context, Color(0xFF121212), Colors.green),
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
                    margin: const EdgeInsets.only(bottom: 10, left: 40, right: 40, top: 10),
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
                            signIn(loginController.text, passwordController.text);
                          },
                          color: onThemeON(context, Color(0xFF333333), Colors.white),
                          child: Text(
                            "Войти",
                            style: TextStyle(color: onThemeON(context, Colors.white, Colors.black)),
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
                              color: onThemeON(context, Color(0xFF333333), Colors.white),
                              child: Text(
                                "Регистрация",
                                style: TextStyle(color: onThemeON(context, Colors.white, Colors.black)),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: onThemeON(context, Color(0xFF333333), Colors.white),
                          child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              launchURL("https://unmei.space/restore");
                            },
                            icon: Icon(Icons.lock_open, color: onThemeON(context, Colors.white, Colors.black)),
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
                      context.watch<DataApp>().changeThemeData
                          ? 0xFF333333
                          : 0xFF597da3,
                      const EdgeInsets.only(right: 5)),
                  accSocialIcon(
                      "https://t.me/unmei_site",
                      "assets/icons/telegram.svg",
                      context.watch<DataApp>().changeThemeData
                          ? 0xFF333333
                          : 0xFF0088cc,
                      const EdgeInsets.only(right: 5)),
                  accSocialIcon(
                      "https://discord.gg/4CA8Cju",
                      "assets/icons/discord.svg",
                      context.watch<DataApp>().changeThemeData
                          ? 0xFF333333
                          : 0xFF7289DA,
                      null),
                ],
              ),
            ),
          ],
        ),
      );

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  signIn(String login, String password) async {
    var data = {'login': login, 'password': password};
    var sharedPref = await SharedPreferences.getInstance();

    var dio = Dio();
    // dio.interceptors.add(InterceptorsWrapper(onRequest: (options) async {
    //   var customHeaders = {
    //     'content-type': 'application/json'
    //   };
    //   options.headers.addAll(customHeaders);
    //   return options;
    // }));
    var response = await dio.post("https://api.unmei.space/v1/auth/login", data: jsonEncode(data));
    print(response.headers.value('token'));

    if (response.statusCode == 200) {
      setState(() => _isLoading = false);

      print(sharedPref.getString("token"));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => UserAccount()));
    } else {
      setState(() => _isLoading = false);
      print(response.data);
    }
  }

  textInput(String text, bool hideText, IconData icon, TextEditingController controller) =>
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
        color: onThemeON(context, Color(0xFF1f1f1f), Colors.green),
        child: ListView(
          children: <Widget>[
            pageHeader("Аккаунт", onThemeON(context, Color(0xFF1f6b22), Colors.white)),
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
          color: onThemeON(context, Color(0xFF121212), Colors.white),
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
                        Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 1,
                              color: Colors.blue
                            )
                          ),
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
                    Column(
                      children: [
                        Icon(Icons.assistant_photo, size: 40, color: Color(0xFF399999)),
                        Text("0", style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.check, size: 40, color: Color(0xFF339933)),
                        Text("0", style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.av_timer, size: 40, color: Color(0xFF993399)),
                        Text("0", style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.ac_unit, size: 40, color: Color(0xFF51d4ff)),
                        Text("0", style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.not_interested, size: 40, color: Color(0xFF993333)),
                        Text("0", style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

// onLogout(context) async {
//   var sharedPref = await SharedPreferences.getInstance();
//   sharedPref.remove("token");
//   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPage()));
//   print("Success exited!");
// }
}
