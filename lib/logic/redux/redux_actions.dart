import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:unmei_fl/data/api/API.dart';
import 'package:unmei_fl/data/model/news_model.dart';
import 'package:unmei_fl/data/model/novels_model.dart';
import 'package:unmei_fl/logic/redux/redux_state.dart';
import 'package:unmei_fl/presentation/widget/news/news_item_widget.dart';
import 'package:unmei_fl/presentation/widget/novels/novel_card_widget.dart';

class GetNewsAction {}

class LoadedNewsAction {
  final Widget widget;

  LoadedNewsAction({required this.widget});
}

ThunkAction loadNewsThunk = (Store store) async {
  store.dispatch(GetNewsAction());
  APIService().getNetworkData<News>(cls: News(), type: "news").then((value) {
    return store.dispatch(LoadedNewsAction(widget: NewsItem(newsList: value)));
  });
};

class GetNovelsAction {}

class LoadedNovelsAction {
  final Widget widget;

  LoadedNovelsAction({required this.widget});
}

Future<ThunkAction<AppState>> loadApp(Store store, String name) async {
  store.dispatch(GetNovelsAction());
  return APIService().getNetworkData<Novels>(cls: Novels(), type: "novels?q=$name").then((value) {
    return store.dispatch(LoadedNovelsAction(widget: NovelCard(novels: value)));
  });
}

ThunkAction<AppState> loadNovelsThunk = (store) async {
  store.dispatch(GetNovelsAction());
  APIService().getNetworkData<Novels>(cls: Novels(), type: "novels?q=").then((value) {
    return store.dispatch(LoadedNovelsAction(widget: NovelCard(novels: value)));
  });
};
