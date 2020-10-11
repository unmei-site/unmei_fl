import 'package:flutter/material.dart';
import 'package:unmei_fl/model/json_model.dart';
import 'package:unmei_fl/widget/utils_widget.dart';

import '../utils.dart';

class NewsItem extends StatelessWidget {

  final News newsList;

  const NewsItem({Key key, this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.data.length,
      itemBuilder: (context, index) =>  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: onThemeON(context, Color(0xFF333333), Colors.blue[100]),
          border: Border.all(
            style: BorderStyle.solid,
            color: onThemeON(context, Color(0xFF121212), Colors.blueAccent),
            width: 2,
          ),
        ),
        margin: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, top: 5),
              child: Text(
                "${newsList.data[index].title}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: onThemeON(context, Colors.white, Colors.black)
                ),
              ),
            ),
            setLine(context),
            Container(
              margin: const EdgeInsets.only(
                  top: 5, bottom: 5, left: 10),
              child: Text(
                "${newsList.data[index].shortPost}",
                style: TextStyle(fontSize: 14, color: onThemeON(context, Colors.white, Colors.black)),
              ),
            ),
            setLine(context),
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: onThemeON(context, Colors.white, Colors.blueAccent),
                        size: 20.0,
                      ),
                      Text(
                        " ${setDateTimeFull(newsList.data[index].date, 3)}",
                        style: TextStyle(
                            fontSize: 14, color: onThemeON(context, Colors.white, Colors.black)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.border_color,
                        color: onThemeON(context, Colors.white, Colors.blueAccent),
                        size: 18.0,
                      ),
                      Text(
                        " ${newsList.data[index].author}",
                        style: TextStyle(
                            fontSize: 14, color: onThemeON(context, Colors.white, Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setLine(context) => Container(
    height: 1,
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    color: onThemeON(context, Colors.white, Colors.black),
  );
}

class NewsItemShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: onShim(120, 0, null),
        ),
      ),
    );
  }
}


