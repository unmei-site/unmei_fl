import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/model/news_model.dart';
import 'package:unmei_fl/data/model/novels_item_model.dart';
import 'package:unmei_fl/data/model/novels_model.dart';
import 'package:unmei_fl/logic/riverprod/river_database.dart';

final newsProvider = FutureProvider<News>((ref) {
  return ref.read(databaseNewsProvider).initNews();
});

final searchControllerNovelsProvider =
StateProvider<TextEditingController>((ref) {
  final textController = TextEditingController();
  ref.onDispose(() {
    return textController.dispose();
  });
  return textController;
});

final novelsProvider = FutureProvider.family<Novels, String>((ref, type) {
  final novelData = ref.read(databaseNovelsProvider);
  return novelData.initNovels(type);
});

final novelItemProvider = FutureProvider.family<NovelsItem, int>((ref, id) {
  return ref.read(databaseNovelsProvider).initNovelsItem(id);
});