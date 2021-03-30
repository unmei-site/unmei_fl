import 'package:flutter/material.dart';
import 'package:unmei_fl/data/model/json_model.dart';
import 'novel_item_widget.dart';

class NovelCard extends StatelessWidget {
  final Novels novelsList;

  NovelCard({this.novelsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: novelsList.data == null ? 0 : novelsList.data.length,
      itemBuilder: (context, index) {
        return Container(
          margin: index == novelsList.data.length - 1
              ? const EdgeInsets.only(top: 15, bottom: 15)
              : const EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NovelItemPage(
                            novelsList: novelsList,
                            index: index,
                          )));
                },
                child: Card(
                  child: Image.network(
                    novelsList.data[index].image,
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == null
                          ? child
                          : LinearProgressIndicator();
                    },
                  ),
                  elevation: 4,
                ),
              ),
              Text(
                "${novelsList.data[index].originalName}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
