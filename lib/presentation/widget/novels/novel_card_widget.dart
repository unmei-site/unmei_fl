import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/model/novels_model.dart';
import 'package:unmei_fl/logic/riverprod/river_providers.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

import '../loader_widget.dart';

class NovelCard extends ConsumerWidget {
  final List<NovelsData>? novels;

  NovelCard({this.novels});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final query = context.read(searchControllerNovelsProvider).state.text;
    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        Color(0xFFFFFFFF),
        Color(0xfffddaff),
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return LoaderWidget(
      indicatorColor: Color(0xFF9915d1),
      onRefresh: () {
        Future.delayed(Duration(milliseconds: 1500), () {
          return context.refresh(novelsProvider(""));
        });
      },
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Image.asset("assets/images/novel_top.jpg"),
                ),
                Text(
                  "Новеллы",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 48),
                    child: TextField(
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
                      controller: watch(searchControllerNovelsProvider).state,
                      onTap: () =>
                          context.read(searchControllerNovelsProvider).state.clear(),
                      onEditingComplete: () {
                        context.read(novelsProvider(query));
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: novels!.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFFa338eb),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print("GOTO");
                      // store.dispatch(loadNovelsItemThunk(store, novels.data![index].id));
                    },
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 150,
                                child: novels![index].image.length > 10
                                    ? Image.network(novels![index].image)
                                    : Image.asset("assets/images/no_image.png"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Color(0xFFe3983d),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star,
                                      size: 14, color: Colors.white),
                                  SizedBox(width: 2),
                                  Text(
                                    novels![index].rating.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
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
                                novels![index].originalName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                novels![index].localizedName.length > 1
                                    ? novels![index].localizedName
                                    : "no name",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
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
          margin: EdgeInsets.only(
              top: 16, left: 16, right: 16, bottom: index == 9 ? 16 : 0),
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
