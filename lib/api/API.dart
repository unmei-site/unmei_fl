import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unmei_fl/model/json_model.dart';

Future<Novels> fetchNovelData() async {
  final response = await http.get('https://api.unmei.space/v1/novels');

  if (response.statusCode == 200) {
    return Novels.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<News> fetchNewsData() async {
  final response = await http.get('https://api.unmei.space/v1/news');

  if (response.statusCode == 200) {
    return News.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}