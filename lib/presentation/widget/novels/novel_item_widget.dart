import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unmei_fl/data/model/novels_item_model.dart';

class NovelItemPage extends StatelessWidget {
  final NovelsItem novel;

  NovelItemPage({required this.novel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Color(0xFFa338eb),
            child: Column(
              children: [
                SizedBox(height: 16),
                GestureDetector(
                  // onTap: () => store.dispatch(loadNovelsThunk(store, "")),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 18, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "Назад",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: novel.data!.image.length > 10
                      ? Image.network(novel.data!.image)
                      : Image.asset("assets/images/no_image.png",
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          novel.data!.originalName,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          novel.data!.localizedName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFFe3983d),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 22, color: Colors.white),
                          SizedBox(width: 2),
                          Text(
                            novel.data!.rating.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF155ad1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  "Краткая справка: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textStyle("Год выпуска: ", "${novel.data!.releaseDate}"),
                  genresConvert("Жанр: ", novel.data!.genres),
                  textStyle("Продолжительность: ", "${novel.data!.duration}"),
                  textStyle("Статус: ", "${statusConvert(novel.data!.exitStatus)}"),
                  textStyle("Платформы: ", "${novel.data!..platforms}"),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFd12b15),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  "Описание: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Text(
                "${novel.data!.description}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget platformConvert(String text) {
    List<Widget> asset = [];
    var listTypes = ["win", "linux", "ios", "android"];
    for (var i in listTypes)
      asset.add(Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: SvgPicture.asset(
            "assets/icons/platform/$i.svg",
            height: 16,
            color: Colors.white,
          )));
    return Row(children: asset);
  }

  genresConvert(String textMain, List<Genres>? genres) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(
              textMain,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF155ad1),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: Color(0xFF9915d1)),
              child: Row(
                children: [
                  if (genres != null) for (var item in genres) Text(item.name),
                  if (genres!.length == 0) Text("-"),
                ],
              ),
            ),
          ],
        ),
      );

  String statusConvert(String text) {
    if (text == "in_developing") return "В разработке";
    if (text == "came_out") return "Вышло";
    if (text == "canceled") return "Отменено";
    if (text == "announcement") return "Анонс";
    if (text == "postponed") return "Перенесено";
    return "";
  }

  textStyle(String textMain, String textDesc) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(
              textMain,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF155ad1),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: Color(0xFF9915d1)),
              child: textMain != "Платформы: "
                  ? Text(
                      textDesc,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : platformConvert(textDesc),
            ),
          ],
        ),
      );
}
