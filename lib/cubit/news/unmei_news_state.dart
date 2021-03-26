part of 'unmei_news_cubit.dart';

@immutable
abstract class UnmeiNewsState {}

class UnmeiNewsInitial extends UnmeiNewsState {}

class UnmeiNewsLoad extends UnmeiNewsState {
  final News news;
  UnmeiNewsLoad({this.news});
}

