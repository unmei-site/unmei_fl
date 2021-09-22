import 'package:flutter/material.dart';
import 'package:unmei_fl/data/model/novels_model.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

import '../loader_widget.dart';

class NovelCard extends StatelessWidget {

  final Novels novels;
  NovelCard({required this.novels});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoaderWidget(
      indicatorColor: Color(0xFF9915d1),
      onRefresh: () {
        Future.delayed(Duration(milliseconds: 1500), () {
          // return context.refresh(novelsProvider(""));
        });
      },
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black54),
                hintText: "Найти...",
                filled: true,
                fillColor: Colors.grey[300],
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
              controller: searchController,
              onEditingComplete: () {
                // context.read(novelsProvider(searchController.text));
                FocusScope.of(context).unfocus();
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: novels.data!.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFFa338eb),
                  ),
                  child: GestureDetector(
                    // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    //     NovelItemPage(id: novels.data[index].id))),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 150,
                                child: novels.data![index].image.length > 10 ? Image.network(novels.data![index].image) : Image.asset("assets/images/no_image.png"),
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
                                    novels.data![index].rating.toString(),
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
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
                                novels.data![index].originalName,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                              ),
                              Text(
                                novels.data![index].localizedName,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, color: Colors.white,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NovelCardShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: index == 9 ? 16 : 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Container(
            height: 100,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                onBoxShim(height: 80, width: 160, radius: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      onBoxShim(height: 25, width: 120, radius: 15),
                      onBoxShim(height: 20, width: 140, radius: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
