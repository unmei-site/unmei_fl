import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:unmei_fl/logic/redux/redux_state.dart';
import 'package:unmei_fl/presentation/page/account_page.dart';
import 'package:unmei_fl/presentation/page/home_page.dart';
import 'package:unmei_fl/presentation/theme.dart';
import 'package:unmei_fl/presentation/widget/news/news_item_widget.dart';
import 'package:unmei_fl/presentation/widget/novels/novel_card_widget.dart';

import 'logic/redux/redux_reducers.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final Store<AppState> appStore = Store(
    appReducer,
    initialState: AppState(
      news: NewsItemShimmer(),
      novels: NovelCardShimmer(),
      // user: AccountPage(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: lightTheme,
      dark: darkTheme,
      builder: (light, dark) => StoreProvider<AppState>(
        store: appStore,
        child: MaterialApp(
          theme: light,
          darkTheme: dark,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }
}
