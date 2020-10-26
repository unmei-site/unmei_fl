import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/bloc/unmei_bloc.dart';
import 'package:unmei_fl/widget/news_item_widget.dart';
import 'package:unmei_fl/widget/utils_widget.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  _loadNews() async {
    context.bloc<UnmeiBloc>().add(InitialUnmei());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: ListView(
        children: <Widget>[
          pageHeader("Новости", Colors.white),
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
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child:
                  BlocBuilder<UnmeiBloc, UnmeiState>(builder: (context, state) {
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
                  return NewsItem(newsList: state.news);
                }
                return NewsItemShimmer();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
