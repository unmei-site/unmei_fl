import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/api/exceptions.dart';
import 'package:unmei_fl/logic/riverprod/river_providers.dart';
import 'package:unmei_fl/presentation/widget/news/news_item_widget.dart';

class NewsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final news = watch(newsProvider);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: news.when(
          data: (content) => NewsItem(newsList: content.data),
          loading: () => NewsItemShimmer(),
          error: (err, trace) => onRequestException(err),
      ),
    );
  }
}
