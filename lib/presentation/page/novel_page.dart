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
    final novels = watch(novelsProvider(""));
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          headerItem(context, watch),
          novels.when(
            data: (content) => buildNovelItem(context, content.data),
            loading: () => buildNovelItemShimmer(),
            error: (err, trace) => onRequestException(err),
          ),
        ],
      ),
    );
  }

  Widget headerItem(BuildContext context, ScopedReader watch) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xFFFFFFFF), Color(0xfffddaff)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Container(
      padding: EdgeInsets.only(bottom: 42),
      child: Stack(
        clipBehavior: Clip.none,
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
              // fontStyle: FontStyle.italic,
              foreground: Paint()..shader = linearGradient,
            ),
          ),
          Positioned(
            bottom: -25,
            width: MediaQuery.of(context).size.width - 32,
            child: searchItem(context, watch),
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
        context.read(novelsProvider(query));
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget buildNovelItem(BuildContext context, List<NovelsData>? novels) => Expanded(
    child: LoaderWidget(
      indicatorColor: Color(0xFF9915d1),
      boxSize: 150,
      onRefresh: () {
        Future.delayed(Duration(milliseconds: 1500), () {
          return context.refresh(novelsProvider(""));
        });
      },
      child: ListView.builder(
        itemCount: novels!.length,
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(
            top: index == 0 ? 0 : 16,
            right: 16,
            left: 16,
            bottom: index == novels.length - 1 ? 16 : 0,
          ),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xFFa338eb),
          ),
          child: GestureDetector(
            onTap: () {
              print("GOTO");
              // store.dispatch(loadNovelsItemThunk(store, novels.data![index].id));
            },
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          child: novels[index].image.length > 10
                              ? Image.network(novels[index].image)
                              : Image.asset("assets/images/no_image.png"),
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
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          novels[index].originalName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          novels[index].localizedName.length > 1
                              ? novels[index].localizedName
                              : "no name",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget buildNovelItemShimmer() => Expanded(
    child: ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.only(
          top: index == 0 ? 0 : 16,
          left: 16,
          right: 16,
          bottom: index == 9 ? 16 : 0,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          height: 100,
          child: Row(
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
