import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/api/API.dart';
import 'package:unmei_fl/data/model/news_model.dart';
import 'package:unmei_fl/data/model/novels_item_model.dart';
import 'package:unmei_fl/data/model/novels_model.dart';

class NewsDatabase {
  Future<News> initNews() async {
    return APIService().getNetworkData(cls: News(), type: 'news');
  }
}

class NovelsDatabase {

  String? name;

  NovelsDatabase({this.name = ""});

  Future<Novels> initNovels() async {
    return APIService().getNetworkData(cls: Novels(), type: "novels?q=$name");
  }

  Future<NovelsItem> initNovelsItem(int id) async {
    return APIService().getNetworkData(cls: NovelsItem(), type: "novels/$id");
  }
}

class NovelsNotifier extends StateNotifier<NovelsDatabase> {
  NovelsNotifier() : super(NovelsDatabase());

  void onSearchNovel(String novelName) {
    state = NovelsDatabase(name: novelName);
  }
}
