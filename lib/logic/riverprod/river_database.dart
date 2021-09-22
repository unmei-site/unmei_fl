// final databaseNewsProvider = Provider<NewsDatabase>((ref) => NewsDatabase());
//
// final databaseNovelsProvider = Provider<NovelsDatabase>((ref) => NovelsDatabase());
//
// class NewsDatabase {
//
//   Future<News> initNews() async {
//     return APIService().getNetworkData(News(), "news");
//   }
// }
//
// class NovelsDatabase {
//
//   Future<Novels> initNovels(String type) async {
//     return await APIService().getNetworkData(Novels(), "novels?q=$type");
//   }
//
//   Future<NovelsItem> initNovelsItem(int id) async {
//     return await APIService().getNetworkData(NovelsItem(), "novels/$id");
//   }
// }