class News {
  bool error;
  List<NewsData> data;

  News({this.error, this.data});

  News.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = new List<NewsData>();
      json['data'].forEach((v) {
        data.add(new NewsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsData {
  int id;
  String title;
  String shortPost;
  String fullPost;
  String date;
  int authorId;
  String author;

  NewsData({this.id,
    this.title,
    this.shortPost,
    this.fullPost,
    this.date,
    this.authorId,
    this.author});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_post'] = this.shortPost;
    data['full_post'] = this.fullPost;
    data['date'] = this.date;
    data['author_id'] = this.authorId;
    data['author'] = this.author;
    return data;
  }
}

class Novels {
  bool error;
  List<NovelsData> data;

  Novels({this.error, this.data});

  Novels.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = new List<NovelsData>();
      json['data'].forEach((v) {
        data.add(new NovelsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null && this.data.length != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NovelsData {
  int id;
  String originalName;
  String localizedName;
  String description;
  String image;
  int rating;
  String releaseDate;

  NovelsData({this.id,
    this.originalName,
    this.localizedName,
    this.description,
    this.image,
    this.rating,
    this.releaseDate});

  NovelsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalName = json['original_name'];
    localizedName = json['localized_name'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['original_name'] = this.originalName;
    data['localized_name'] = this.localizedName;
    data['description'] = this.description;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['release_date'] = this.releaseDate;
    return data;
  }
}