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

  Novels novels;
  News news;

  @override
  Stream<UnmeiState> mapEventToState(UnmeiEvent event) async* {
    if (event is InitialUnmei) {
      yield UnmeiInitial();
      try {
        news = await getInfoData(News(), "news");

        var novelName = event.text;
        novels = await getInfoData(Novels(), "novels?q=$novelName");
        yield UnmeiLoaded(news: news, novels: novels);

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
}
