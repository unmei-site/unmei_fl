import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unmei_fl/presentation/app_route.dart';
import 'package:unmei_fl/presentation/theme.dart';
import 'package:unmei_fl/presentation/widget/bottom_nav_widget.dart';

import 'logic/bloc/user/unmei_user_bloc.dart';
import 'logic/cubit/news/unmei_news_cubit.dart';
import 'logic/cubit/novels/unmei_novels_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

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
            BlocProvider<UnmeiUserBloc>(
              create: (userContext) => UnmeiUserBloc(),
            ),
          ],
          child: BottomNavigation(),
        ),
      ),
    );
  }
}
