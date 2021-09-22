class Login {
  bool error;
  String data;

  Login({required this.error, required this.data});

  fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['data'] = this.data;
    return data;
  }
}

abstract class DataResponse {
  fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}