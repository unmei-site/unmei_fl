// final newsProvider = FutureProvider<News>((ref) {
//   return ref.read(databaseNewsProvider).initNews();
// });
//
// final novelsProvider = FutureProvider.family<Novels, String>((ref, type) {
//   final novelData = ref.watch(databaseNovelsProvider);
//   return novelData.initNovels(type);
// });
//
// final novelItemProvider = FutureProvider.family<NovelsItem, int>((ref, id) {
//   return ref.read(databaseNovelsProvider).initNovelsItem(id);
// });