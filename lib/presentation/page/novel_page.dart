import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:unmei_fl/logic/cubit/novels/unmei_novels_cubit.dart';
import 'package:unmei_fl/presentation/widget/news_item_widget.dart';
import 'package:unmei_fl/presentation/widget/novel_card_widget.dart';
import 'package:unmei_fl/presentation/widget/utils_widget.dart';
import 'package:unmei_fl/utils.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: GestureDetector(
              onTap: () => showToast(context, "Входить в аккаунт пока нельзя 😒", Colors.red[900], Icons.cancel),
                child: SvgPicture.asset("assets/icons/user.svg"),
            ),
          ),
        ),
        title: Text("Новеллы", style: TextStyle(fontSize: 32, color: Colors.black)),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
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
              onChanged: (text) {
                _loadNovels();
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height/4.5),
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
    );
  }
}