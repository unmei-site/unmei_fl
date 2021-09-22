import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unmei_fl/data/model/app_model.dart';
import 'package:unmei_fl/utils.dart';

class APIService {

  final Dio client = Dio();

  final String url = "https://api.unmei.space/v1/";

  late PersistCookieJar persistentCookies;
  final storage = FlutterSecureStorage();

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
      baseUrl: url,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    final Directory dir = await _localCookieDirectory;
    final cookiePath = dir.path;
    persistentCookies = new PersistCookieJar(storage: FileStorage(cookiePath));
    client.interceptors.add(CookieManager(persistentCookies));
  }

  onLogin(context, {required String login, required String pass}) async {
    try {
      init();
      final formData = {
        "login": login,
        "password": pass,
      };
      Response response = await client.post(
          "auth/login?auth_type=token", data: formData);
      var request = response.data;

      if (response.statusCode == 200) {
        showToast(context, "Добро пожаловать!", (Colors.lightGreen[700])!,
            Icons.done);
        Navigator.of(context).pop();
      }
      await storage.write(key: 'token', value: request['data']);
      _token = (await storage.read(key: 'token'))!;
      print("TOKEN " + _token);
      print("DATA ${response.data}");
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.statusCode.toString() + " " +
            (e.response!.statusMessage)!);
        print("Data body: ${e.response!.data}");
        print("Headers: [ ${e.response!.headers} ]");
        print("Options: ${e.response!.requestOptions}");
        showToast(context, "Неверный логин и/или пароль!", (Colors.red[700])!,
            Icons.done);
      } else {
        print("Request options: ${e.requestOptions}");
        print("Error message: ${e.message}");
      }
    }
    catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<T> getNetworkData<T extends DataResponse>({required T cls, required String type}) async {
    final response = await client.get('https://api.unmei.nix13.dev/v1/$type');
    final completer = new Completer<T>();
    if (response.statusCode == 200) {
      cls.fromJson(response.data);
      completer.complete(cls);
      return completer.future;
    } else {
      print("Error from getting Data: ${response.data}");
      throw Exception('Failed to load data');
    }
  }

  void removeToken() async {
    await storage.delete(key: 'token');
    _token = "";
  }

  void onGetToken(void state) async {
    _token = (await storage.read(key: 'token'))!;
    return state;
  }
}