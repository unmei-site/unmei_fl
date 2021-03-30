part of 'unmei_user_cubit.dart';

@immutable
abstract class UnmeiUserState {}

class UnmeiUserInitial extends UnmeiUserState {}

class UnmeiUserLoad extends UnmeiUserState {
  final User user;
  UnmeiUserLoad({this.user});
}
