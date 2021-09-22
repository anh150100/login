import 'dart:async';
import 'dart:convert';
import 'package:api_login/data_resources/api_url.dart';
import 'package:api_login/models/response_user.dart';
import 'package:api_login/models/user.dart';
import 'package:api_login/pages/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class AuthController extends ChangeNotifier {
  bool isLoading = false;
  UserInfo? appUser;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ConstantsApi.constant.baseUrl,
    connectTimeout: 3000,
    receiveTimeout: 3000,
  ));

  Future<ResponseUserInfo> signUp({
    required String name,
    required String email,
    required String pass,
    required String rePass,
  }) async {
    try {
      final String endPoint = '/auth/register';
      var body = FormData.fromMap({
        'name' : name,
        'email' : email,
        'password': pass,
        'retype_password' : rePass,
      });
      Response response = await _dio.post(endPoint,data: body);
      var data = jsonDecode(response.toString());
      return ResponseUserInfo.fromJson(data);
    } on DioError catch (e){
      if(e.type == DioErrorType.connectTimeout){
        return ResponseUserInfo(status:"fail",message: "time out error");
      }
      if(e.type == DioErrorType.receiveTimeout){
        return ResponseUserInfo(status:"fail",message: "time out error");
      }
      if(e.response == null){
        return ResponseUserInfo(status: "fail",message: "no internet");
      }else {
        return ResponseUserInfo(status: "fail",message: e.message);
      }
    }
  }

  Future signIn(String email,String pass,BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass
    };
    const String apiEndpoint = 'https://itesteverything.com/api/auth/login'; // Replace with your own api url
    final Uri url = Uri.parse(apiEndpoint);
    var jsonResponse = null;
    var response = await http.post(url, body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        unLoading();
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
      }
    }
    else {
      unLoading();
      print(response.body);
    }
  }
  Future<ResponseUserInfo> fetchUserInfoModel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Authorization' : "Bearer ${sharedPreferences.getString("token")}",
      'Accept' : "application/json" };
    const String userUrl = "http://itesteverything.com/api/auth/user";// Replace with your own api url
    final Uri url = Uri.parse(userUrl);
    http.Response response = await http.get(url,headers: headers);
    if (response.statusCode == 200) {
      return ResponseUserInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  bool get count => isLoading;
  void loading() {
    isLoading = true;
    notifyListeners();
  }

  void unLoading() {
    isLoading = false;
    notifyListeners();
  }
}