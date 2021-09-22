import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unmei_fl/data/api/API.dart';

import '../../utils.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late TextEditingController loginController;
  late TextEditingController passwordController;

  late bool isFocusedLogin;
  late bool isFocusedPass;

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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text("Аккаунт", style: TextStyle(fontSize: 32, color: Colors.black)),
        elevation: 0,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: loginBody(),
          ),
        ),
      ),
    );
  }

  loginBody() => Column(
    children: [
      SizedBox(height: MediaQuery.of(context).size.height/24),
      Column(
        children: [
          Text(
            "Unmei",
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w100,
                color: Colors.black,
                decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 4),
          SvgPicture.asset("assets/icons/user.svg", height: 128),
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
      SizedBox(height: MediaQuery.of(context).size.height/24),
      Column(
        children: [
          TextButton(
            onPressed: () {
              APIService().onLogin(context, login: loginController.text, pass: passwordController.text);
              FocusScope.of(context).unfocus();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16, horizontal: 48)),
            ),
            child: Text("Войти", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Text("или", style: TextStyle(fontSize: 16, color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              launchURL("https://unmei.space/");
              FocusScope.of(context).unfocus();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16, horizontal: 48)),
            ),
            child: Text("Зарегистрироваться", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
      SizedBox(height: MediaQuery.of(context).size.height/24),
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
                edge: null!,
              ),
            ],
          ),
        ],
      ),
    ],
  );

  accountBodyAuth() => Column(
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
                    APIService().removeToken();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(""),
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
                  style:
                  TextStyle(fontSize: 18, color: Color(0xFF0073FF)),
                ),
                SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 32),
      Text(
        "Новеллы",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
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
                  Text("Весь список",
                      style:
                      TextStyle(fontSize: 18, color: Colors.black)),
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
          Text(n,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ],
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
