import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/presentation/app_route.dart';
import 'package:unmei_fl/presentation/theme.dart';
import 'package:unmei_fl/presentation/widget/bottom_nav_widget.dart';

import 'logic/cubit/news/unmei_news_cubit.dart';
import 'logic/cubit/novels/unmei_novels_cubit.dart';
import 'logic/cubit/user/unmei_user_cubit.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: lightTheme,
      dark: darkTheme,
      builder: (light, dark) => MaterialApp(
        theme: light,
        darkTheme: dark,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UnmeiNewsCubit>(
              create: (newsContext) => UnmeiNewsCubit(),
            ),
            BlocProvider<UnmeiNovelsCubit>(
              create: (novelsContext) => UnmeiNovelsCubit(),
            ),
            BlocProvider<UnmeiUserCubit>(
              create: (userContext) => UnmeiUserCubit(),
            ),
          ],
          child: BottomNavigation(),
        ),
      ),
    );
  }
}
