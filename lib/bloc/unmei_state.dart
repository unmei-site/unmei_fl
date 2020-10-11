part of 'unmei_bloc.dart';

@immutable
abstract class UnmeiState {}

class UnmeiInitial extends UnmeiState {}

class UnmeiLoaded extends UnmeiState {
  final News news;
  final Novels novels;

  UnmeiLoaded({this.news, this.novels});
}

class UnmeiError extends UnmeiState {
  final error;

  UnmeiError({this.error});
}
