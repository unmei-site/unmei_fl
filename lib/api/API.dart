import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unmei_fl/model/json_model.dart';

abstract class UnmeiRepo {
  Future<T> getInfoData <T>(String type);
  // Future<Users> getUser(String name);
}

class UnmeiServices implements UnmeiRepo {

  Future<T> getInfoData<T>(String type) async {
    final response = await http.get('https://api.unmei.space/v1/$type');
    if (response.statusCode == 200) {
      return T as Future<T>;
    } else {
      throw Exception('Failed to load data');
    }
  }

// Future<Login> fetchUser(String login, String password) async {
//   var data = {'login': login, 'password': password};
//   final response = await http.post('https://api.unmei.space/v1/auth/login?auth_type=token', body: jsonEncode(data));

//   if (response.statusCode == 200) {
//     var jBody = jsonDecode(response.body);
//     return jBody['token'];
//   } else {
//     throw Exception('Failed to load data');
//   }
// }
}

class T {
}

  Future<Novels> fetchNovelData() async {
    final response = await http.get('https://api.unmei.space/v1/novels');

    if (response.statusCode == 200) {
      return Novels.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }