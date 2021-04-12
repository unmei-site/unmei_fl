import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:unmei_fl/data/api/API.dart';
import 'package:unmei_fl/data/model/json_model.dart';

part 'unmei_novels_state.dart';

class UnmeiNovelsCubit extends Cubit<UnmeiNovelsState> {
  UnmeiNovelsCubit() : super(UnmeiNovelsInitial());

  Novels novels;

  void getNovels({String text = ""}) async {
    novels = await APIService().getNetworkData(Novels(), "novels?q=$text");
    emit(UnmeiNovelsLoad(novels: novels));
  }
}
