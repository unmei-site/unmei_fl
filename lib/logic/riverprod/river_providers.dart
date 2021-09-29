import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/model/news_model.dart';
import 'package:unmei_fl/data/model/novels_item_model.dart';
import 'package:unmei_fl/data/model/novels_model.dart';
import 'package:unmei_fl/logic/riverprod/river_database.dart';

final databaseNewsProvider = Provider<NewsDatabase>((ref) => NewsDatabase());
final databaseNovelsProvider = Provider<NovelsDatabase>((ref) => NovelsDatabase());

final stateNotifierProvider = StateNotifierProvider<NovelsNotifier, NovelsDatabase>((ref) => NovelsNotifier());

final newsProvider = FutureProvider<News>((ref) async {
  final newsData = ref.watch(databaseNewsProvider);
  return newsData.initNews();
});

final searchControllerNovelsProvider =
    StateProvider<TextEditingController>((ref) {
  final textController = TextEditingController();
  ref.onDispose(() {
    return textController.dispose();
  });
  return textController;
});

final novelsProvider = FutureProvider<Novels>((ref) async {
  final novelData = ref.watch(databaseNovelsProvider);
  return novelData.initNovels();
});

final novelItemProvider =
    FutureProvider.family<NovelsItem, int>((ref, id) async {
  final novelData = ref.watch(databaseNovelsProvider);
  return novelData.initNovelsItem(id);
});
