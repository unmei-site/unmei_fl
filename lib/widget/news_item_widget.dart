import 'package:flutter/material.dart';
import 'package:unmei_fl/api/API.dart';
import 'package:unmei_fl/model/json_model.dart';

import '../utils.dart';

class NewsItem extends StatefulWidget {

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {

  var _newsList = News();
  var _newsListDisplay = News();

  @override
  void initState() {
    fetchNewsData().then((value) {
      setState(() {
        _newsList.data = [];
        _newsList.data.addAll(value.data);
        _newsListDisplay.data = _newsList.data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: _newsList.data == null ? 0 : _newsList.data.length,
        itemBuilder: (context, index) {
          return Container(
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
                    "${_newsList.data[index].title}",
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
                    "${_newsList.data[index].shortPost}",
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
                            " ${setDateTimeFull(_newsList.data[index].date, 3)}",
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
                            " ${_newsList.data[index].author}",
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
          );
        },
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

