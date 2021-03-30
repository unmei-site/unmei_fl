part of 'unmei_news_cubit.dart';

@immutable
abstract class UnmeiNewsState {}

class UnmeiNewsInitial extends UnmeiNewsState {}

class UnmeiNewsLoaded extends UnmeiNewsState {
  final News news;

  UnmeiNewsLoaded({this.news});
}
