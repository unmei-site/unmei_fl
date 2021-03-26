import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unmei_fl/api/API.dart';
import 'package:unmei_fl/model/json_model.dart';

part 'unmei_novels_state.dart';

class UnmeiNovelsCubit extends Cubit<UnmeiNovelsState> {
  UnmeiNovelsCubit() : super(UnmeiNovelsInitial());

  Novels novels;

  void getNovels(String text) async {
    novels = await getNetworkData(Novels(), "novels?q=$text");
    emit(UnmeiNovelsLoad(novels: novels));
  }
}
