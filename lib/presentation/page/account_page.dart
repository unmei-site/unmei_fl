import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unmei_fl/data/api/API.dart';

import '../../utils.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final TextEditingController loginController;
  late final TextEditingController passwordController;

  late final bool isFocusedLogin;
  late final bool isFocusedPass;

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();

    isFocusedLogin = false;
    isFocusedPass = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/24),
                Column(
                  children: [
                    Card(
                      color: Color(0xFF1D1D36),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                        child: Text(
                          "Unmei",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "С возвращением!",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
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
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/36),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: accountButton(
                            onClick: () {
                              APIService().onLogin(context, login: loginController.text, pass: passwordController.text);
                              FocusScope.of(context).unfocus();
                            } ,
                            name: "Войти",
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: accountButton(
                            onClick: () {
                              launchURL("https://unmei.space/");
                              FocusScope.of(context).unfocus();
                            } ,
                            name: "Зарегистрироваться",
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Text("или", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: accountButton(
                            onClick: () {
                              APIService().onLogin(context, login: loginController.text, pass: passwordController.text);
                              FocusScope.of(context).unfocus();
                            } ,
                            name: "Продолжить без входа",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/8),
                Column(
                  children: [
                    Text("Посетите нас на других платформах!", style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                          edge: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  accountButton({VoidCallback? onClick, required String name}) => TextButton(
    onPressed: onClick,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blue),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
    ),
    child: Text(name, style: TextStyle(fontSize: 18, color: Colors.white)),
  );

  textFiledForm(
          {required TextEditingController controller,
          required String label,
          required IconData icon,
          required TextInputType inputType,
          required TextInputAction action,
          bool hideText = false,
          required bool isOn}) =>
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
          {required String url,
          required String icon,
          required String label,
          required int color,
          required EdgeInsets edge}) =>
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
}
