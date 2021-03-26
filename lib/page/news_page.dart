import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/cubit/news/unmei_news_cubit.dart';
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
    context.read<UnmeiNewsCubit>().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: ListView(
        children: <Widget>[
          pageHeader("Новости", context),
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
              child: BlocBuilder<UnmeiNewsCubit, UnmeiNewsState>(
                builder: (context, state) {
                  if (state is UnmeiNewsInitial) return NewsItemShimmer();
                  if (state is UnmeiNewsLoad) return NewsItem(newsList: state.news);
                  return Center(
                    child: Text(
                      "Произошла ошибка :(",
                      style: TextStyle(fontSize: 24, color: Colors.red),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
