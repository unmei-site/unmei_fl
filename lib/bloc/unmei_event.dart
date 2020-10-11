part of 'unmei_bloc.dart';

@immutable
abstract class UnmeiEvent {}

class InitialUnmei extends UnmeiEvent {
  final String text;


  

  InitialUnmei({this.text});
}