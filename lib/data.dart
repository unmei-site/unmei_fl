import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataApp with ChangeNotifier {
  bool _changeTheme = false;

  get changeThemeData => _changeTheme;

  void onChangeTheme(bool doChange) async {
    var sharePref = await SharedPreferences.getInstance();
    changeThemeData ? sharePref.setBool("themeSwitch", _changeTheme) : sharePref.setBool("themeSwitch", !_changeTheme);
    _changeTheme = doChange;
    notifyListeners();
  }
}