import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unmei_fl/data/api/exceptions.dart';
import 'package:unmei_fl/logic/riverprod/river_providers.dart';
import 'package:unmei_fl/presentation/widget/novels/novel_card_widget.dart';

class NovelsPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final novels = watch(novelsProvider(""));
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: novels.when(
        data: (content) => NovelCard(novels: content.data),
        loading: () => NovelCardShimmer(),
        error: (err, trace) => onRequestException(err),
      ),
    );
  }
}
