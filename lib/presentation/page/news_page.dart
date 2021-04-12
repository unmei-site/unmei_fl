import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/logic/cubit/news/unmei_news_cubit.dart';
import 'package:unmei_fl/presentation/widget/news_item_widget.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<UnmeiNewsCubit, UnmeiNewsState>(builder: (context, state) {
        if (state is UnmeiNewsLoading) return NewsItemShimmer();
        if (state is UnmeiNewsLoaded) return NewsItem(newsList: state.news);
        return Center(
          child: Text(
            "Произошла ошибка :(",
            style: TextStyle(fontSize: 24, color: Colors.red),
          ),
        );
      }),
    );
  }
}
