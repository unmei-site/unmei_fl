import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unmei_fl/data/model/json_model.dart';

class APIService {

  final Dio client = Dio();
  PersistCookieJar persistentCookies;
  final storage = FlutterSecureStorage();
  final String url = "https://api.unmei.space/v1/";

  String _token = "";
  String get getToken => _token;

  Future<Directory> get _localCookieDirectory async {
    final directory = await getApplicationDocumentsDirectory();
    final Directory dir = new Directory('${directory.path}/cookies');
    await dir.create();
    return dir;
  }

  init() async {
    client.options = BaseOptions(
        baseUrl: url
    );
    final Directory dir = await _localCookieDirectory;
    final cookiePath = dir.path;
    persistentCookies = new PersistCookieJar(dir: '$cookiePath');
    client.interceptors.add(CookieManager(persistentCookies));
  }

  onLogin(String login, String pass) async {
    try {
      init();
      final formData = {
        "login": login,
        "password": pass,
      };
      Response response = await client.post("auth/login?auth_type=token", data: formData);
      var request = response.data;
      await storage.write(key: 'token', value: request['data']);
      _token = await storage.read(key: 'token');
      print("TOKEN " + _token);
      print("DATA ${response.data}");
    } on DioError catch(e) {
      if (e.response != null) {
        print( e.response.statusCode.toString() + " " + e.response.statusMessage);
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    }
    catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<T> getNetworkData<T extends DataResponse>(T cls, String type) async {
    final response = await client.get('https://api.unmei.space/v1/$type');
    final completer = new Completer<T>();
    if (response.statusCode == 200) {
      cls.fromJson(response.data);
      completer.complete(cls);
      return completer.future;
    } else {
      print(response.data);
      throw Exception('Failed to load data');
    }
  }

  void removeToken() async {
    await storage.delete(key: 'token');
    _token = "";
  }

  void onGetToken(void state) async {
    _token = await storage.read(key: 'token');
    if (_token != null) return state;
  }
}