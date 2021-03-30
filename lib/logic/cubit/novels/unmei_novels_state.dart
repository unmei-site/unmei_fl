part of 'unmei_novels_cubit.dart';

@immutable
abstract class UnmeiNovelsState {}

class UnmeiNovelsInitial extends UnmeiNovelsState {}

class UnmeiNovelsLoad extends UnmeiNovelsState {
  final Novels novels;

  UnmeiNovelsLoad({this.novels});
}
