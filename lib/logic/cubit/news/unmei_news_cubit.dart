import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:unmei_fl/data/api/API.dart';
import 'package:unmei_fl/data/model/json_model.dart';

part 'unmei_news_state.dart';

class UnmeiNewsCubit extends Cubit<UnmeiNewsState> {
  UnmeiNewsCubit() : super(UnmeiNewsLoading());

  News news;

  void getNews() async {
    news = await APIService().getNetworkData(News(), "news");
    emit(UnmeiNewsLoaded(news: news));
  }
}
