import 'package:flutter/material.dart';
import 'package:unmei_fl/data/model/json_model.dart';
import 'package:unmei_fl/presentation/widget/novel_item_widget.dart';

class NovelCard extends StatelessWidget {
  final Novels novelsList;

  NovelCard({this.novelsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: novelsList.data.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(top: 16, right: 16, left: 16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFa338eb),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NovelItemPage(index: index, novelsList: novelsList))),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 150,
                      child: novelsList.data[index].image.length > 10 ? Image.network(novelsList.data[index].image) : Image.asset("assets/images/no_image.png"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFe3983d),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.white),
                        SizedBox(width: 2),
                        Text(
                          novelsList.data[index].rating.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      novelsList.data[index].originalName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      novelsList.data[index].localizedName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}