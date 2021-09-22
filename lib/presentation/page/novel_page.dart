import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:unmei_fl/logic/redux/redux_actions.dart';
import 'package:unmei_fl/logic/redux/redux_state.dart';

class NovelsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (_) => store.dispatch(loadApp(store, "")),
        builder: (context, vm) {
          return vm.novels;
        },
      ),
    );
  }
}
