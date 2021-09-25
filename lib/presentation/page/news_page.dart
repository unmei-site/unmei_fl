import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/api/exceptions.dart';
import 'package:unmei_fl/data/model/news_model.dart';
import 'package:unmei_fl/logic/riverprod/river_providers.dart';
import 'package:unmei_fl/presentation/widget/loader_widget.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';
import 'package:unmei_fl/utils.dart';

class NewsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final news = watch(newsProvider);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          headerItem(context),
          SizedBox(height: 16),
          news.when(
            data: (content) => buildNewsItem(context, content.data),
            loading: () => buildNewsItemShimmer(),
            error: (err, trace) => onRequestException(err),
          ),
        ],
      ),
    );
  }

  Widget headerItem(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xff84b1ff), Color(0xff005bff)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: Image.asset("assets/images/news_top.jpg"),
        ),
        Text(
          "Новости",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
      ],
    );
  }

  Widget buildNewsItem(BuildContext context, List<NewsData>? news) => Expanded(
        child: LoaderWidget(
          indicatorColor: Color(0xFF3f85ff),
          onRefresh: () {
            Future.delayed(Duration(milliseconds: 1500), () {
              return context.refresh(newsProvider);
            });
          },
          child: ListView.builder(
            itemCount: news!.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(
                top: index == 0 ? 0 : 16,
                right: 16,
                left: 16,
                bottom: index == news.length - 1 ? 16 : 0,
              ),
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
                              "${news[index].author}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF3f85ff),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${news[index].title}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      "${news[index].shortPost}",
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
                              "${setDateTimeFull(news[index].date, 3)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF3f85ff),
                              ),
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

  Widget buildNewsItemShimmer() => Expanded(
        child: ListView.builder(
          itemCount: 10,
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) => Card(
            margin: EdgeInsets.only(
              top: index == 0 ? 0 : 16,
              left: 16,
              right: 16,
              bottom: index == 9 ? 16 : 0,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Container(
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
