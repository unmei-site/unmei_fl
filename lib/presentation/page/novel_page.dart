import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:unmei_fl/logic/cubit/novels/unmei_novels_cubit.dart';
import 'package:unmei_fl/presentation/widget/news_item_widget.dart';
import 'package:unmei_fl/presentation/widget/novel_card_widget.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';

class NovelsPage extends StatefulWidget {
  @override
  _NovelsPageState createState() => _NovelsPageState();
}

class _NovelsPageState extends State<NovelsPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNovels();
  }

  _loadNovels() {
    context.read<UnmeiNovelsCubit>().getNovels(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: ListView(
        children: <Widget>[
          pageHeader("Новеллы", context),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
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
                    controller: searchController,
                    onChanged: (text) {
                      _loadNovels();
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
                  child: BlocBuilder<UnmeiNovelsCubit, UnmeiNovelsState>(builder: (context, state) {
                    if (state is UnmeiNovelsInitial) return NewsItemShimmer();
                    if (state is UnmeiNovelsLoad) return NovelCard(novelsList: state.novels);
                    return Center(
                      child: Text(
                        "Произошла ошибка :(",
                        style: TextStyle(fontSize: 24, color: Colors.red),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
