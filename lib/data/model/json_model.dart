class Login {
  bool error;
  String data;

  Login({this.error, this.data});

  Login.fromJson(Map<String, dynamic> json) {
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

class News implements DataResponse {
  bool error;
  List<NewsData> data;

  News({this.error, this.data});

  @override
  fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <NewsData>[];
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

  NewsData(
      {this.id,
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

class Novels implements DataResponse {
  bool error;
  List<NovelsData> data;

  Novels({this.error, this.data});

  fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <NovelsData>[];
      json['data'].forEach((v) {
        data.add(new NovelsData.fromJson(v));
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

class NovelsData {
  int id;
  String originalName;
  String localizedName;
  String description;
  String image;
  int rating;
  String releaseDate;
  int duration;
  String exitStatus;
  String platforms;
  List<Genres> genres;
  List<Links> links;

  NovelsData(
      {this.id,
        this.originalName,
        this.localizedName,
        this.description,
        this.image,
        this.rating,
        this.releaseDate,
        this.duration,
        this.exitStatus,
        this.platforms,
        this.genres,
        this.links});

  NovelsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalName = json['original_name'];
    localizedName = json['localized_name'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'];
    releaseDate = json['release_date'];
    duration = json['duration'];
    exitStatus = json['exit_status'];
    platforms = json['platforms'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
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
    data['duration'] = this.duration;
    data['exit_status'] = this.exitStatus;
    data['platforms'] = this.platforms;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genres {
  int id;
  String name;
  String localizedName;

  Genres({this.id, this.name, this.localizedName});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizedName = json['localized_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['localized_name'] = this.localizedName;
    return data;
  }
}

class Links {
  int novelId;
  String name;
  String link;
  String type;

  Links({this.novelId, this.name, this.link, this.type});

  Links.fromJson(Map<String, dynamic> json) {
    novelId = json['novel_id'];
    name = json['name'];
    link = json['link'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['novel_id'] = this.novelId;
    data['name'] = this.name;
    data['link'] = this.link;
    data['type'] = this.type;
    return data;
  }
}

class User implements DataResponse {
  bool error;
  UserData data;

  User({this.error, this.data});

  @override
  fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserData {
  int id;
  String username;
  String regDate;
  String lastSeen;
  String avatar;
  bool isSuperuser;
  bool isActivated;
  UserGroup group;
  String cover;
  bool useGravatar;
  String theme;
  bool isBanned;

  UserData(
      {this.id,
        this.username,
        this.regDate,
        this.lastSeen,
        this.avatar,
        this.isSuperuser,
        this.isActivated,
        this.group,
        this.cover,
        this.useGravatar,
        this.theme,
        this.isBanned});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    regDate = json['reg_date'];
    lastSeen = json['last_seen'];
    avatar = json['avatar'];
    isSuperuser = json['is_superuser'];
    isActivated = json['is_activated'];
    group = json['group'] != null ? new UserGroup.fromJson(json['group']) : null;
    cover = json['cover'];
    useGravatar = json['use_gravatar'];
    theme = json['theme'];
    isBanned = json['is_banned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['reg_date'] = this.regDate;
    data['last_seen'] = this.lastSeen;
    data['avatar'] = this.avatar;
    data['is_superuser'] = this.isSuperuser;
    data['is_activated'] = this.isActivated;
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    data['cover'] = this.cover;
    data['use_gravatar'] = this.useGravatar;
    data['theme'] = this.theme;
    data['is_banned'] = this.isBanned;
    return data;
  }
}

class UserGroup {
  int id;
  String name;
  String color;
  int maxAvatarSize;
  int maxAvatarWeight;
  bool isSuperuser;
  String permissions;

  UserGroup(
      {this.id,
        this.name,
        this.color,
        this.maxAvatarSize,
        this.maxAvatarWeight,
        this.isSuperuser,
        this.permissions});

  UserGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    maxAvatarSize = json['max_avatar_size'];
    maxAvatarWeight = json['max_avatar_weight'];
    isSuperuser = json['is_superuser'];
    permissions = json['permissions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['max_avatar_size'] = this.maxAvatarSize;
    data['max_avatar_weight'] = this.maxAvatarWeight;
    data['is_superuser'] = this.isSuperuser;
    data['permissions'] = this.permissions;
    return data;
  }
}