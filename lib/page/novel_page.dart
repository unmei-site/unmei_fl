import 'package:flutter/material.dart';
import 'package:unmei_fl/api/API.dart';
import 'package:unmei_fl/model/json_model.dart';
import 'package:unmei_fl/widget/novel_card_widget.dart';

import '../utils.dart';

class NovelsPage extends StatefulWidget {
  @override
  _NovelsPageState createState() => _NovelsPageState();
}

class _NovelsPageState extends State<NovelsPage> {
  var _novelsList = Novels();
  var _novelsListDisplay = Novels();

  @override
  void initState() {
    fetchNovelData().then((value) {
      setState(() {
        _novelsList.data = [];
        _novelsList.data.addAll(value.data);
        _novelsListDisplay.data = _novelsList.data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: onThemeON(context, Color(0xFF1F1F1F), Colors.deepPurple),
      child: ListView(
        children: <Widget>[
          pageHeader("Новеллы", onThemeON(context, Color(0xFF22156b), Colors.white)),
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
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  height: 40,
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      hintText: "Найти...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      text = text.toLowerCase();
                      setState(() {
                        _novelsListDisplay.data = _novelsList.data.where((novel) {
                          var noteTitle = novel.originalName.toLowerCase();
                          return noteTitle.contains(text);
                        }).toList();
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 250,
                  child: NovelCard(novelsList: _novelsListDisplay),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
