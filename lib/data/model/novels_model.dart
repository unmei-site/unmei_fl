import 'package:unmei_fl/data/model/app_model.dart';

import 'novels_item_model.dart';

class Novels implements DataResponse {
  Novels({
    this.error,
    this.data,
  });
  bool? error;
  List<NovelsData>? data;

  @override
  fromJson(Map<String, dynamic> json){
    error = json['error'];
    data = List.from(json['data']).map((e)=>NovelsData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class NovelsData {
  NovelsData({
    required this.id,
    required this.originalName,
    required this.localizedName,
    required this.image,
    required this.rating,
    required this.releaseDate,
    required this.exitStatus,
    required this.isDemo,
    required this.genres,
  });
  late final int id;
  late final String originalName;
  late final String localizedName;
  late final String image;
  late final int rating;
  late final String releaseDate;
  late final String exitStatus;
  late final bool isDemo;
  late final List<Genres> genres;

  NovelsData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    originalName = json['original_name'];
    localizedName = json['localized_name'];
    image = json['image'];
    rating = json['rating'];
    releaseDate = json['release_date'];
    exitStatus = json['exit_status'];
    isDemo = json['is_demo'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['original_name'] = originalName;
    _data['localized_name'] = localizedName;
    _data['image'] = image;
    _data['rating'] = rating;
    _data['release_date'] = releaseDate;
    _data['exit_status'] = exitStatus;
    _data['is_demo'] = isDemo;
    _data['genres'] = this.genres.map((v) => v.toJson()).toList();
    return _data;
  }
}