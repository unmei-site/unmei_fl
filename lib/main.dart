import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:unmei_fl/bloc/unmei_bloc.dart';
import 'package:unmei_fl/widget/bottom_nav_widget.dart';

import 'data.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataApp>(
      create: (context) => DataApp(),
      child: MaterialApp(
        title: 'Unmei',
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => UnmeiBloc(),
          child: BottomNavigation(),
        ),
      ),
    );
  }
}
