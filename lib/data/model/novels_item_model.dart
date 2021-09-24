import 'app_model.dart';

class NovelsItem implements DataResponse {
  NovelsItem({
    this.error,
    this.data,
  });
  bool? error;
  NovelsItemData? data;

  @override
  fromJson(Map<String, dynamic> json){
    error = json['error'];
    data = NovelsItemData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class NovelsItemData {
  NovelsItemData({
    required this.id,
    required this.originalName,
    required this.localizedName,
    required this.description,
    required this.image,
    required this.rating,
    required this.releaseDate,
    required this.duration,
    required this.exitStatus,
    required this.isDemo,
    required this.platforms,
    required this.genres,
    required this.links,
    required this.walkthrough,
    required this.ratingAll,
    required this.statusAll,
  });
  late final int id;
  late final String originalName;
  late final String localizedName;
  late final String description;
  late final String image;
  late final int rating;
  late final String releaseDate;
  late final int duration;
  late final String exitStatus;
  late final bool isDemo;
  late final String platforms;
  late final List<Genres> genres;
  late final List<Links> links;
  late final String walkthrough;
  late final List<RatingAll> ratingAll;
  late final List<StatusAll> statusAll;

  NovelsItemData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    originalName = json['original_name'];
    localizedName = json['localized_name'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'];
    releaseDate = json['release_date'];
    duration = json['duration'];
    exitStatus = json['exit_status'];
    isDemo = json['is_demo'];
    platforms = json['platforms'];
    genres = List.from(json['genres']).map((e)=>Genres.fromJson(e)).toList();
    links = List.from(json['links']).map((e)=>Links.fromJson(e)).toList();
    walkthrough = json['walkthrough'];
    ratingAll = List.from(json['rating_all']).map((e)=>RatingAll.fromJson(e)).toList();
    statusAll = List.from(json['status_all']).map((e)=>StatusAll.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['original_name'] = originalName;
    _data['localized_name'] = localizedName;
    _data['description'] = description;
    _data['image'] = image;
    _data['rating'] = rating;
    _data['release_date'] = releaseDate;
    _data['duration'] = duration;
    _data['exit_status'] = exitStatus;
    _data['is_demo'] = isDemo;
    _data['platforms'] = platforms;
    _data['genres'] = genres.map((e)=>e.toJson()).toList();
    _data['links'] = links.map((e)=>e.toJson()).toList();
    _data['walkthrough'] = walkthrough;
    _data['rating_all'] = ratingAll.map((e)=>e.toJson()).toList();
    _data['status_all'] = statusAll.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Genres {
  Genres({
    required this.id,
    required this.name,
    required this.localizedName,
  });
  late final int id;
  late final String name;
  late final String localizedName;

  Genres.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    localizedName = json['localized_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['localized_name'] = localizedName;
    return _data;
  }
}

class Links {
  Links({
    required this.novelId,
    required this.name,
    required this.link,
    required this.type,
  });
  late final int novelId;
  late final String name;
  late final String link;
  late final String type;

  Links.fromJson(Map<String, dynamic> json){
    novelId = json['novel_id'];
    name = json['name'];
    link = json['link'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['novel_id'] = novelId;
    _data['name'] = name;
    _data['link'] = link;
    _data['type'] = type;
    return _data;
  }
}

class RatingAll {
  RatingAll({
    required this.mark,
    required this.count,
  });
  late final int mark;
  late final int count;

  RatingAll.fromJson(Map<String, dynamic> json){
    mark = json['mark'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mark'] = mark;
    _data['count'] = count;
    return _data;
  }
}

class StatusAll {
  StatusAll({
    required this.status,
    required this.count,
  });
  late final String status;
  late final int count;

  StatusAll.fromJson(Map<String, dynamic> json){
    status = json['status'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['count'] = count;
    return _data;
  }
}