import 'package:flutter/material.dart';
import 'package:unmei_fl/data/model/json_model.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

import '../../utils.dart';

class NewsItem extends StatelessWidget {
  final News newsList;

  const NewsItem({this.newsList}) : super();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.data.length,
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
                        "${newsList.data[index].author}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF3f85ff)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              "${newsList.data[index].title}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                "${newsList.data[index].shortPost}",
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
                        "${setDateTimeFull(newsList.data[index].date, 3)}",
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
    );
  }
}

class NewsItemShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 20),
          child: onShim(120, 0, null),
        ),
      ),
    );
  }
}
