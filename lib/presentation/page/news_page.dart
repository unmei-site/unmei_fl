import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unmei_fl/logic/cubit/news/unmei_news_cubit.dart';
import 'package:unmei_fl/presentation/widget/news_item_widget.dart';

import '../../utils.dart';

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
              onTap: () => showToast(context, "Входить в аккаунт пока нельзя ☹️", Colors.red[900], Icons.cancel),
              child: SvgPicture.asset("assets/icons/user.svg"),
            ),
          ),
        ),
        title: Text("Новости", style: TextStyle(fontSize: 32, color: Colors.black)),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<UnmeiNewsCubit, UnmeiNewsState>(
          builder: (context, state) {
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
