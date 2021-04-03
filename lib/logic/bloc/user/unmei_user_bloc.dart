import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'unmei_user_event.dart';
part 'unmei_user_state.dart';

class UnmeiUserBloc extends Bloc<UnmeiUserEvent, UnmeiUserState> {
  UnmeiUserBloc() : super(UnmeiUserInitial());

  @override
  Stream<UnmeiUserState> mapEventToState(
    UnmeiUserEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
