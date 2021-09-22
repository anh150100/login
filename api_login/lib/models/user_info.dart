class Example {
  String? status;
  String? message;
  Data? data;

  Example({this.status, this.message, this.data});

  Example.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.message = json["message"];
    this.data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if(this.data != null)
      data["data"] = this.data?.toJson();
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? nationality;
  String? image;
  String? following;
  String? followers;
  String? followingTopics;
  dynamic? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.name, this.email, this.nationality, this.image, this.following, this.followers, this.followingTopics, this.emailVerifiedAt, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.nationality = json["nationality"];
    this.image = json["image"];
    this.following = json["following"];
    this.followers = json["followers"];
    this.followingTopics = json["following_topics"];
    this.emailVerifiedAt = json["email_verified_at"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["email"] = this.email;
    data["nationality"] = this.nationality;
    data["image"] = this.image;
    data["following"] = this.following;
    data["followers"] = this.followers;
    data["following_topics"] = this.followingTopics;
    data["email_verified_at"] = this.emailVerifiedAt;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}