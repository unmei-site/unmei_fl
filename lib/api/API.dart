import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unmei_fl/model/json_model.dart';

Future<T> getInfoData<T extends Response>(T cls, String type) async {
  final response = await http.get('https://api.unmei.space/v1/$type');
  final completer = new Completer<T>();
  if (response.statusCode == 200) {
    cls.fromJson(jsonDecode(response.body));
    completer.complete(cls);
    return completer.future;
  } else {
    throw Exception('Failed to load data');
  }
}
