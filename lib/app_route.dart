import 'package:flutter/material.dart';
import 'package:unmei_fl/presentation/page/account_page.dart';
import 'package:unmei_fl/presentation/page/news_page.dart';
import 'package:unmei_fl/presentation/page/novel_page.dart';
import 'package:unmei_fl/presentation/page/settings_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/news':
        return MaterialPageRoute(
          builder: (_) => NewsPage(),
        );
      case '/novels':
        return MaterialPageRoute(
          builder: (_) => NovelsPage(),
        );
      case '/account':
        return MaterialPageRoute(
          builder: (_) => AccountPage(),
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => SettingsPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => NewsPage(),
        );;
    }
  }
}