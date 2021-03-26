import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unmei_fl/api/API.dart';
import 'package:unmei_fl/api/exceptions.dart';
import 'package:unmei_fl/model/json_model.dart';

part 'unmei_event.dart';
part 'unmei_state.dart';

class UnmeiBloc extends Bloc<UnmeiEvent, UnmeiState> {

  UnmeiBloc() : super(UnmeiInitial());

  News news;
  Novels novels;
  User user;

  @override
  Stream<UnmeiState> mapEventToState(UnmeiEvent event) async* {
    try {
      if (event is InitialUnmeiNews) {
        yield UnmeiInitial();
        news = await getNetworkData(News(), "news");
        yield UnmeiLoadNews(news: news);
      } else if (event is InitialUnmeiNovel) {
        yield UnmeiInitial();
        novels = await getNetworkData(Novels(), "novels?q=${event.text}");
        yield UnmeiLoadNovels(novels: novels);
      } else if (event is InitialUnmeiUser) {
        yield UnmeiInitial();
        user = await getNetworkData(User(), "users/1");
        yield UnmeiLoadUser(user: user);
      }
    } on SocketException {
      yield UnmeiError(
        error: NoInternetException('No Internet'),
      );
    } on HttpException {
      yield UnmeiError(
        error: NoServiceFoundException('No Service Found'),
      );
    } on FormatException {
      yield UnmeiError(
        error: InvalidFormatException('Invalid Response Format'),
      );
    } catch (e) {
      yield UnmeiError(
        error: UnknownException('Unknown Error'),
      );
    }
  }
}
