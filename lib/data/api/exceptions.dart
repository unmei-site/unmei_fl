import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NoInternetException {
  String message;
  NoInternetException(this.message);
}

class NoServiceFoundException {
  String message;
  NoServiceFoundException(this.message);
}

class InvalidFormatException {
  String message;
  InvalidFormatException(this.message);
}

class UnknownException {
  String message;
  UnknownException(this.message);
}

onRequestException(err) {
  if ((err as DioError).type == DioErrorType.other) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/no_internet.png", width: 256),
          Card(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Text("Нет интернет соединения D:", style: TextStyle(color: Colors.red[800], fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
  return Text(
    "Произошла ошибка :(\n$err",
    style: TextStyle(fontSize: 16, color: Colors.red),
  );
}