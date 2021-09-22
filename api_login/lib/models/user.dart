class UserInfo {
  int? id;
  String? name;
  String? email;
  String? image;
  String? following;
  String? followers;
  String? followingTopics;
  String? nationality;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  UserInfo({
    this.id,
    this.name,
    this.email,
    this.image,
    this.following = "",
    this.followers,
    this.followingTopics,
    this.nationality,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt
  });
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo (
        id : json['id'],
        name : json['name'],
        email : json['email'],
        image : json['image'],
        following : json['following'],
        followers : json['followers'],
        followingTopics : json["following_topics"],
        nationality : json['nationality'],
        emailVerifiedAt : json['email_verified_at'],
        createdAt : json['created_at'],
        updatedAt : json['updated_at'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['following'] = following;
    data['followers'] = followers;
    data['following_topics'] = followingTopics;
    data['nationality'] = nationality;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

