import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:unmei_fl/data/model/news_model.dart';
import 'package:unmei_fl/logic/riverprod/river_providers.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

import '../../../utils.dart';
import '../loader_widget.dart';

class NewsItem extends ConsumerWidget {

  final List<NewsData>? newsList;

  NewsItem({this.newsList});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return LoaderWidget(
      indicatorColor: Color(0xFF3f85ff),
      onRefresh: () {
        Future.delayed(Duration(milliseconds: 1500), () {
          return context.refresh(newsProvider);
        });
      },
      child: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          itemCount: newsList!.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(top: 16, right: 16, left: 16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color(0xFF3f85ff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.account_circle, size: 18, color: Color(0xFF3f85ff)),
                          SizedBox(width: 4),
                          Text(
                            "${newsList![index].author}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF3f85ff)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "${newsList![index].title}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    "${newsList![index].shortPost}",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.date_range, size: 18, color: Color(0xFF3f85ff)),
                          SizedBox(width: 4),
                          Text(
                            "${setDateTimeFull(newsList![index].date, 3)}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF3f85ff)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsItemShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: index == 9 ? 16 : 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Container(
            height: 205,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                onBoxShim(height: 20, width: 100, radius: 15),
                onBoxShim(height: 25, width: 200, radius: 15, margin: EdgeInsets.only(top: 8)),
                onBoxShim(height: 80, width: 300, radius: 15, margin: EdgeInsets.only(top: 8)),
                onBoxShim(height: 20, width: 180, radius: 15, margin: EdgeInsets.only(top: 8)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
