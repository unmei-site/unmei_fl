import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei_fl/logic/cubit/novels/unmei_novels_cubit.dart';

import 'package:unmei_fl/presentation/widget/novel_card_widget.dart';

class NovelsPage extends StatefulWidget {
  @override
  _NovelsPageState createState() => _NovelsPageState();
}

class _NovelsPageState extends State<NovelsPage> {

  @override
  void initState() {
    super.initState();
    context.read<UnmeiNovelsCubit>().getNovels(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<UnmeiNovelsCubit, UnmeiNovelsState>(builder: (context, state) {
        if (state is UnmeiNovelsInitial) return NovelCardShimmer();
        if (state is UnmeiNovelsLoad) return NovelCard(novels: state.novels);
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