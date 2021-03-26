part of 'unmei_bloc.dart';

@immutable
abstract class UnmeiState {}

class UnmeiInitial extends UnmeiState {}

class UnmeiLoadNews extends UnmeiState {
  final News news;
  UnmeiLoadNews({this.news});
}

class UnmeiLoadNovels extends UnmeiState {
  final Novels novels;
  UnmeiLoadNovels({this.novels});
}

class UnmeiLoadUser extends UnmeiState {
  final User user;
  UnmeiLoadUser({this.user});
}

class UnmeiError extends UnmeiState {
  final error;
  UnmeiError({this.error});
}
