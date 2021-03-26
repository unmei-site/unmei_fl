import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unmei_fl/api/API.dart';
import 'package:unmei_fl/model/json_model.dart';

part 'unmei_news_state.dart';

class UnmeiNewsCubit extends Cubit<UnmeiNewsState> {
  UnmeiNewsCubit() : super(UnmeiNewsInitial());

  News news;

  void getNews() async {
    news = await getNetworkData(News(), "news");
    emit(UnmeiNewsLoad(news: news));
  }
}
