import 'package:unmei_fl/data/model/app_model.dart';

class News implements DataResponse {

  bool? error;
  Pagination? pagination;
  List<NewsData>? data;

  News({
    this.error,
    this.pagination,
    this.data,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    error = json['error'];
    pagination = Pagination.fromJson(json['pagination']);
    data = List.from(json['data']).map((e) => NewsData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['pagination'] = pagination!.toJson();
    _data['data'] = data!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Pagination {
  Pagination({
    required this.limit,
    required this.offset,
    required this.total,
  });

  late final int limit;
  late final int offset;
  late final int total;

  Pagination.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['limit'] = limit;
    _data['offset'] = offset;
    _data['total'] = total;
    return _data;
  }
}

class NewsData {
  NewsData({
    required this.id,
    required this.title,
    required this.shortPost,
    required this.fullPost,
    required this.date,
    required this.authorId,
    required this.author,
  });

  late final int id;
  late final String title;
  late final String shortPost;
  late final String fullPost;
  late final String date;
  late final int authorId;
  late final String author;

  NewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortPost = json['short_post'];
    fullPost = json['full_post'];
    date = json['date'];
    authorId = json['author_id'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['short_post'] = shortPost;
    _data['full_post'] = fullPost;
    _data['date'] = date;
    _data['author_id'] = authorId;
    _data['author'] = author;
    return _data;
  }
}
