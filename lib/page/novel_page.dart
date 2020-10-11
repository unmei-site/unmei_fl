import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/bloc/unmei_bloc.dart';
import 'package:unmei_fl/widget/news_item_widget.dart';
import 'package:unmei_fl/widget/novel_card_widget.dart';
import 'package:unmei_fl/widget/utils_widget.dart';

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

  _loadNovels() async {
    context.bloc<UnmeiBloc>().add(InitialUnmei(text: searchController.text));
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
                  child: BlocBuilder<UnmeiBloc, UnmeiState>(builder: (context, state) {
                    if (state is UnmeiError) {
                      // return Retry(
                      //   message: "Неверный формат имени покемона!",
                      // );
                      print("Error parse!!!");
                    }
                    if (state is UnmeiInitial) {
                      return NewsItemShimmer();
                    }
                    if (state is UnmeiLoaded) {
                      return NovelCard(novelsList: state.novels);
                    }
                    // return NewsItemShimmer();
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