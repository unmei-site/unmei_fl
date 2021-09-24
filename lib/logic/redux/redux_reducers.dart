// import 'package:flutter/material.dart';
// import 'package:redux/redux.dart';
// import 'package:unmei_fl/logic/redux/redux_actions.dart';
// import 'package:unmei_fl/logic/redux/redux_state.dart';
// import 'package:unmei_fl/presentation/widget/news/news_item_widget.dart';
// import 'package:unmei_fl/presentation/widget/novels/novel_card_widget.dart';
//
// AppState appReducer(AppState state, dynamic action) => AppState(
//       news: _newsReducer(state.news, action),
//       novels: _novelsReducer(state.novels, action),
//     );
//
// Reducer<Widget> _newsReducer = combineReducers([
//   TypedReducer(_getNewsData),
//   TypedReducer(_loadedNewsData),
// ]);
//
// Widget _getNewsData(Widget widget, GetNewsAction action) => Center(child: NewsItemShimmer());
// Widget _loadedNewsData(Widget widget, LoadedNewsAction action) => action.widget;
//
// Reducer<Widget> _novelsReducer = combineReducers([
//   TypedReducer(_getNovelsData),
//   TypedReducer(_loadedNovelsData),
// ]);
//
// Widget _getNovelsData(Widget widget, GetNovelsAction action) => Center(child: NovelCardShimmer());
// Widget _loadedNovelsData(Widget widget, LoadedNovelsAction action) => action.widget;