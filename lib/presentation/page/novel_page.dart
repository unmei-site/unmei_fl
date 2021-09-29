import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/api/exceptions.dart';
import 'package:unmei_fl/data/model/novels_model.dart';
import 'package:unmei_fl/logic/riverprod/river_providers.dart';
import 'package:unmei_fl/presentation/widget/loader_widget.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

class NovelsPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final novels = watch(novelsProvider);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        title: Text("Новеллы", style: TextStyle(fontSize: 32, color: Colors.black)),
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          searchItem(context, watch),
          SizedBox(height: 8),
          novels.when(
            data: (content) => buildNovelItem(context, content.data),
            loading: () => buildNovelItemShimmer(),
            error: (err, trace) => onRequestException(err),
          ),
        ],
      ),
    );
  }

  Widget searchItem(BuildContext context, ScopedReader watch) {
    final query = context.read(searchControllerNovelsProvider).state.text;
    return TextField(
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.black54),
        hintText: "Найти...",
        filled: true,
        fillColor: Color(0xFFF2D4FF),
        hintStyle: TextStyle(color: Colors.black54),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      controller: watch(searchControllerNovelsProvider).state,
      onTap: () => context.read(searchControllerNovelsProvider).state.clear(),
      onEditingComplete: () {
        context.read(stateNotifierProvider.notifier).onSearchNovel(query);
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget buildNovelItem(BuildContext context, List<NovelsData>? novels) =>
      Expanded(
        child: LoaderWidget(
          indicatorColor: Color(0xFF9915d1),
          boxSize: 150,
          onRefresh: () {
            Future.delayed(Duration(milliseconds: 1500), () {
              return context.refresh(novelsProvider);
            });
          },
          child: GridView.builder(
            itemCount: novels!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(
                top: index == 0 && index == 1 ? 0 : 8,
                left: index % 2 == 0 ? 8 : 8,
                right: index % 2 == 0 ? 0 : 8,
                bottom: index == novels.length - 1 && index == novels.length - 2 ? 8 : 0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  print("GOTO");
                  context.read(databaseNovelsProvider).initNovelsItem(index);
                  // store.dispatch(loadNovelsItemThunk(store, novels.data![index].id));
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1)),
                            ),
                            child: Image.network(novels[index].image),
                          ),
                        ),
                        Row(
                          children: [
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
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    novels[index].rating.toString(),
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
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 8, left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      novels[index].localizedName.length > 1
                                          ? novels[index].localizedName
                                          : "no name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      novels[index].originalName,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF263238),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // TextButton(
                        //   onPressed: () => print("GO TO"),
                        //   style: ButtonStyle(
                        //     shape: MaterialStateProperty.all(
                        //       RoundedRectangleBorder(
                        //         side: BorderSide(width: 1, color: Color(0xFF0E4DA4)),
                        //         borderRadius: BorderRadius.all(Radius.circular(8)),
                        //       ),
                        //     ),
                        //     padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                        //     overlayColor: MaterialStateProperty.all(Color(0xFFC7DBFF)),
                        //     backgroundColor: MaterialStateProperty.all(Colors.white),
                        //   ),
                        //   child: Text("Подробнее", style: TextStyle(fontSize: 8, color: Color(0xFF0E4DA4))),
                        // ),
                      ],
                    ),
                    // GestureDetector(
                    //   onTap: () => print("GO TO"),
                    //   child: Container(
                    //     padding: EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(8)),
                    //       border: Border.all(width: 1, color: Color(0xFF0E4DA4)),
                    //     ),
                    //     child: Text("Подробнее", style: TextStyle(fontSize: 10, color: Color(0xFF0E4DA4))),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildNovelItemShimmer() => Expanded(
        child: GridView.builder(
          itemCount: 14,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) => Card(
            margin: EdgeInsets.only(
              top: index == 0 && index == 1 ? 0 : 8,
              left: index % 2 == 0 ? 8 : 8,
              right: index % 2 == 0 ? 0 : 8,
              bottom: index == 13 && index == 12 ? 8 : 0,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Container(
              height: 100,
              child: Column(
                children: [
                  Expanded(
                    child: onBoxShim(margin: EdgeInsets.all(8), radius: 8),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        onBoxShim(height: 25, width: 120, radius: 16),
                        onBoxShim(height: 20, width: 140, radius: 16),
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
