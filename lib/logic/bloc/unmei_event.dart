part of 'unmei_bloc.dart';

@immutable
abstract class UnmeiEvent {}

class InitialUnmeiNews extends UnmeiEvent {}

class InitialUnmeiNovel extends UnmeiEvent {
  final String text;
  InitialUnmeiNovel({this.text});
}

class InitialUnmeiUser extends UnmeiEvent {}