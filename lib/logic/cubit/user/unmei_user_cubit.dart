import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:unmei_fl/data/api/API.dart';
import 'package:unmei_fl/data/model/json_model.dart';

part 'unmei_user_state.dart';

class UnmeiUserCubit extends Cubit<UnmeiUserState> {
  UnmeiUserCubit() : super(UnmeiUserInitial());

  User user;

  void getUser() async {
    user = await APIService().getNetworkData(User(), "users/me");
    emit(UnmeiUserLoad(user: user));
  }
}
