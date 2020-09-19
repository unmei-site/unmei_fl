import 'package:flutter/material.dart';
import 'package:unmei_fl/widget/news_item_widget.dart';

import '../utils.dart';

class NewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: onThemeON(context, Color(0xFF1F1F1F), Colors.blue),
      child: ListView(
        children: <Widget>[
          pageHeader("Новости", onThemeON(context, Color(0xFF062d6b), Colors.white)),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: onThemeON(context, Color(0xFF121212), Colors.white),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: NewsItem(),
          ),
        ],
      ),
    );
  }
}
