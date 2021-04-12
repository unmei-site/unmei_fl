import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/data/model/json_model.dart';
import 'package:unmei_fl/logic/cubit/novels/unmei_novels_cubit.dart';
import 'package:unmei_fl/presentation/widget/novel_item_widget.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

import 'loader_widget.dart';

class NovelCard extends StatefulWidget {

  final Novels novels;

  const NovelCard({this.novels});

  @override
  _NovelCardState createState() => _NovelCardState();
}

class _NovelCardState extends State<NovelCard> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadNovels();
  }

  loadNovels() {
    context.read<UnmeiNovelsCubit>().getNovels(text: searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return LoaderWidget(
      indicatorColor: Color(0xFF9915d1),
      onRefresh: () => loadNovels(),
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
              onChanged: (text) => loadNovels(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.novels.data.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFFa338eb),
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NovelItemPage(index: index, novelsList: widget.novels))),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 150,
                                child: widget.novels.data[index].image.length > 10 ? Image.network(widget.novels.data[index].image) : Image.asset("assets/images/no_image.png"),
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
                                    widget.novels.data[index].rating.toString(),
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
                                widget.novels.data[index].originalName,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                              ),
                              Text(
                                widget.novels.data[index].localizedName,
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
