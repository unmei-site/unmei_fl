import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/bloc/unmei_bloc.dart';
import 'package:unmei_fl/theme.dart';
import 'package:unmei_fl/widget/bottom_nav_widget.dart';

import 'cubit/news/unmei_news_cubit.dart';
import 'cubit/novels/unmei_novels_cubit.dart';
import 'cubit/user/unmei_user_cubit.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: lightTheme,
      dark: darkTheme,
      builder: (light, dark) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UnmeiNewsCubit>(
              create: (_) => UnmeiNewsCubit(),
            ),
            BlocProvider<UnmeiNovelsCubit>(
              create: (_) => UnmeiNovelsCubit(),
            ),
            BlocProvider<UnmeiUserCubit>(
              create: (_) => UnmeiUserCubit(),
            ),
          ],
          child: BottomNavigation(),
        ),
      ),
    );
  }
}
