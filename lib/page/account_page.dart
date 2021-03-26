import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unmei_fl/bloc/unmei_bloc.dart';
import 'package:unmei_fl/cubit/user/unmei_user_cubit.dart';
import 'package:unmei_fl/model/json_model.dart';
import 'package:unmei_fl/widget/utils_widget.dart';

import 'package:http/http.dart' as http;

import '../utils.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController loginController;
  TextEditingController passwordController;

  bool isFocusedLogin;
  bool isFocusedPass;

  String token;
  String userID;

  @override
  void initState() {
    super.initState();
    context.read<UnmeiUserCubit>().getUser(userID);
    loginController = TextEditingController();
    passwordController = TextEditingController();

    isFocusedLogin = false;
    isFocusedPass = false;

    token = "";
    userID = "";
  }

  removeToken() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('token');
    token = "";
  }

  @override
  void dispose() {
    super.dispose();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  "Аккаунт",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              BlocBuilder<UnmeiUserCubit, UnmeiUserState>(
                  builder: (context, state) {
                    if (state is UnmeiUserInitial) return Text("ERROR", style: TextStyle(color: Colors.black));
                    if (state is UnmeiUserLoad) return containerBlock(state.user);
                    return Center(
                      child: Text(
                        "Произошла ошибка :(",
                        style: TextStyle(fontSize: 24, color: Colors.red),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerBlock(User user) {
    Widget vars = Container();
    token.length > 1 ? vars = accountBodyAuth(user) : vars = accountBody();
    return vars;
  }

  accountBody() => Column(
        children: [
          Text(
            "Unmei",
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w100,
                color: Colors.black,
                decoration: TextDecoration.underline),
          ),
          SizedBox(height: 16),
          Text(
            "С возвращением!",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            "Войдите в свой аккаунт чтобы сохранять понравившиеся новеллы и оставлять отзывы. Это поможет развитию приложения, сайта и сообщества Unmei.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Focus(
            onFocusChange: (focus) {
              setState(() {
                isFocusedLogin = focus;
              });
            },
            child: textFiledForm(
              controller: loginController,
              inputType: TextInputType.emailAddress,
              action: TextInputAction.next,
              icon: Icons.account_circle_outlined,
              label: "Логин",
              isOn: isFocusedLogin,
            ),
          ),
          SizedBox(height: 8),
          Focus(
            onFocusChange: (focus) {
              setState(() {
                isFocusedPass = focus;
              });
            },
            child: textFiledForm(
              controller: passwordController,
              inputType: TextInputType.visiblePassword,
              action: TextInputAction.done,
              icon: Icons.lock_outline_rounded,
              label: "Пароль",
              hideText: true,
              isOn: isFocusedPass,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              launchURL("https://unmei.space/restore");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Забыли пароль?", style: TextStyle(fontSize: 14, color: Colors.black)),
                SizedBox(width: 4),
                Icon(Icons.lock_open, size: 18),
              ],
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              signIn(loginController.text, passwordController.text);
              FocusScope.of(context).unfocus();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 48)),
            ),
            child: Text("Войти",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child:
                Text("или", style: TextStyle(fontSize: 16, color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              launchURL("https://unmei.space/");
              FocusScope.of(context).unfocus();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 48)),
            ),
            child: Text("Зарегистрироваться",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          SizedBox(height: 48),
          Text("Посетите нас на других платформах!",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              accSocialIcon(
                label: "ВКонтакте",
                url: "https://vk.com/unmei_site",
                color: 0xFF597da3,
                icon: "assets/icons/vk.svg",
                edge: EdgeInsets.only(right: 8),
              ),
              accSocialIcon(
                label: "Telegram",
                url: "https://t.me/unmei_site",
                icon: "assets/icons/telegram.svg",
                edge: EdgeInsets.only(right: 8),
                color: 0xFF0088cc,
              ),
              accSocialIcon(
                label: "Discord",
                url: "https://discord.gg/4CA8Cju",
                icon: "assets/icons/discord.svg",
                color: 0xFF7289DA,
                edge: null,
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      );

  accountBodyAuth(User user) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      removeToken();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(user.data.avatar),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "RonFall",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "Android dev.",
                  style: TextStyle(fontSize: 18, color: Color(0xFF0073FF)),
                ),
                SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 32),
      Text("Новеллы", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                flagIcon("0", Icons.assistant_photo, 0xFF399999),
                flagIcon("0", Icons.check, 0xFF339933),
                flagIcon("0", Icons.av_timer, 0xFF993399),
                flagIcon("0", Icons.ac_unit, 0xFF51d4ff),
                flagIcon("0", Icons.not_interested, 0xFF993333),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Весь список", style: TextStyle(fontSize: 18, color: Colors.black)),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ],
  );

  flagIcon(String n, IconData icon, int color) => Column(
    children: [
      Icon(icon, size: 30, color: Color(color)),
      Text(n, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
    ],
  );

  textFiledForm(
          {TextEditingController controller,
          String label,
          IconData icon,
          TextInputType inputType,
          TextInputAction action,
          bool hideText = false,
          bool isOn}) =>
      TextFormField(
        controller: controller,
        keyboardType: inputType,
        cursorColor: Colors.black,
        style: TextStyle(color: isOn ? Colors.blue : Colors.grey),
        textInputAction: action,
        obscureText: hideText,
        onFieldSubmitted: (str) {
          label == "Логин"
              ? FocusScope.of(context).nextFocus()
              : FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isOn ? Colors.blue : Colors.grey),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(icon, color: isOn ? Colors.blue : Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      );

  accSocialIcon(
          {String url,
          String icon,
          String label,
          int color,
          EdgeInsets edge}) =>
      GestureDetector(
        onTap: () {
          launchURL(url);
        },
        child: Container(
          margin: edge,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(color),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgPicture.asset(icon, height: 16),
              SizedBox(width: 8),
              Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      );

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
                            setState(() {});
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
                  // accSocialIcon(
                  //     "https://vk.com/unmei_site",
                  //     "assets/icons/vk.svg",
                  //     0xFF597da3,
                  //     const EdgeInsets.only(right: 15)),
                  // accSocialIcon(
                  //     "https://t.me/unmei_site",
                  //     "assets/icons/telegram.svg",
                  //     0xFF0088cc,
                  //     const EdgeInsets.only(right: 15)),
                  // accSocialIcon("https://discord.gg/4CA8Cju",
                  //     "assets/icons/discord.svg", 0xFF7289DA, null),
                ],
              ),
            ),
          ],
        ),
      );

  signIn(String login, String password) async {
    var data = {
      'login': login,
      'password': password,
    };

    var resp = await http.post("https://api.unmei.space/v1/auth/login?auth_type=token", body: jsonEncode(data));
    if (resp.statusCode == 200) {
      var request = jsonDecode(resp.body);
      final storage = await SharedPreferences.getInstance();
      storage.setString('token', request['data']);
      setState(() {
        token += storage.getString('token');
      });
      showToast(context, "Добро пожаловать!", Colors.green, Icons.check);
    } else {
      print(resp.body);
      showToast(context, "Неверный логин и/или пароль!", Colors.red, Icons.cancel);
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
}

class UserAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: ListView(
          children: <Widget>[
            pageHeader("Аккаунт", context),
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
    goTo(context, AccountPage());
    showToast(context, "Возвращайтесь!", Colors.amber, Icons.next_plan);
    print("Success exited!");
  }
}
