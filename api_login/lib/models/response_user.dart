

import 'package:api_login/models/user.dart';

class ResponseUserInfo{
  String? status;
  String? message;
  String? token;
  UserInfo? data;
  ResponseUserInfo({this.status, this.message, this.token, this.data});
  ResponseUserInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? new UserInfo.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}
