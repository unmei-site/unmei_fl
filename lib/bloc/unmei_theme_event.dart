part of 'unmei_theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeConfig theme;

  ThemeChanged({
    this.theme,
  });
}
