import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/presentation/page/home_page.dart';
import 'package:unmei_fl/presentation/theme.dart';

import 'app_route.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  // final Store<AppState> appStore = Store(
  //   appReducer,
  //   middleware: [thunkMiddleware],
  //   initialState: AppState(
  //     news: NewsItemShimmer(),
  //     novels: NovelCardShimmer(),
  //     // user: AccountPage(),
  //   ),
  // );

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: lightTheme,
      dark: darkTheme,
      builder: (light, dark) => ProviderScope(
        child: MaterialApp(
          onGenerateRoute: appRouter.onGenerateRoute,
          theme: light,
          darkTheme: dark,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }
}
