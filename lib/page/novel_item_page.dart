import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unmei_fl/model/json_model.dart';

import '../utils.dart';

class NovelItemPage extends StatelessWidget {
  final Novels novelsList;
  final num index;

  NovelItemPage({this.novelsList, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Image(
                image: NetworkImage("${novelsList.data[index].image}"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${novelsList.data[index].originalName}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "${novelsList.data[index].rating}",
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(
                        Icons.star,
                        size: 22,
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textStyle("Локализированное имя: ${novelsList.data[index].localizedName}"),
                    textStyle("Год выпуска: ${setDateTimeYear(novelsList.data[index].releaseDate)}"),
                    textStyle("Жанр: "),
                    textStyle("Продолжительность"),
                    textStyle("Статус: "),
                    textStyle("Платформы: "),
                    textStyle("Ваша оценка: "),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text(
                "${novelsList.data[index].description}",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  textStyle(String text) =>
      Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500));
}
