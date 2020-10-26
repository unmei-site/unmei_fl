import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:unmei_fl/theme.dart';

part 'unmei_theme_event.dart';
part 'unmei_theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChanged) {
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    return ThemeState(
        themeData: appThemeData[ThemeConfig.values[json['themeMode'] as int]]);
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {'themeMode': appThemeData[state.themeConfig.index]};
  }
}
