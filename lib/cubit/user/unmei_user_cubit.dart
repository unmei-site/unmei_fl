import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unmei_fl/api/API.dart';
import 'package:unmei_fl/model/json_model.dart';

part 'unmei_user_state.dart';

class UnmeiUserCubit extends Cubit<UnmeiUserState> {
  UnmeiUserCubit() : super(UnmeiUserInitial());

  User user;

  void getUser(String userID) async {
    user = await getNetworkData(User(), "users/me");
    emit(UnmeiUserLoad(user: user));
  }
}
