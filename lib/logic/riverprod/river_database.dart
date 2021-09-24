import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/api/API.dart';
import 'package:unmei_fl/data/model/news_model.dart';
import 'package:unmei_fl/data/model/novels_item_model.dart';
import 'package:unmei_fl/data/model/novels_model.dart';

final databaseNewsProvider = Provider<NewsDatabase>((ref) => NewsDatabase());

final databaseNovelsProvider = Provider<NovelsDatabase>((ref) => NovelsDatabase());

class NewsDatabase {

  Future<News> initNews() async {
    return await APIService().getNetworkData(cls: News(), type: 'news');
  }
}

class NovelsDatabase {

  Future<Novels> initNovels(String name) async {
    return await APIService().getNetworkData(cls: Novels(), type: "novels?q=$name");
  }

  Future<NovelsItem> initNovelsItem(int id) async {
    return await APIService().getNetworkData(cls: NovelsItem(), type: "novels/$id");
  }
}