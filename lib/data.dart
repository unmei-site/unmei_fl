import 'package:flutter/widgets.dart';

class DataApp with ChangeNotifier {
  bool _changeTheme = false;

  get changeThemeData => _changeTheme;

  void onChangeTheme(bool doChange) async {
    _changeTheme = doChange;
    notifyListeners();
  }
}