// ignore_for_file: prefer_final_fields, invalid_return_type_for_catch_error

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/register_model.dart';

abstract class ILoginRepository {
  Future<String> login(String username, String password);
  Future<Map<String, dynamic>> loginWithPhone(String phoneNumber);
  Future<bool> isPhoneInDatabase(String phoneNumber);
  Future<BaseResponse> help(Map<String, String> map);

  Future<BaseResponse> register(RegisterModel registerModel);
}

class LoginRepository implements ILoginRepository {
  late Dio _dio;

  LoginRepository(this._dio);

  @override
  Future<String> login(String email, String password) async {
    Map<String, String> body = {"username_email": email, "password": password};
    var res = await _dio
        .post(Constant.baseUrl + Constant.login, data: body)
        .catchError((onError) {
      return Future.error(onError);
    });
    if (res.statusCode == 200 && res.data["success"]) {
      Constant.accessToken = res.data["access_token"];
      return Future.value(res.data["access_token"]);
    }
    return Future.error("Giriş Başarısız.");
  }

  @override
  Future<Map<String, dynamic>> loginWithPhone(String phoneNumber) async {
    Map<String, String> body = {"phoneNumber": phoneNumber};
    try {
      var res = await _dio.post(Constant.baseUrl + Constant.loginWithPhone,
          data: body);
      if (res.statusCode == 200 && res.data["isSuccess"]) {
        Constant.pin = res.data["pin"];
        return Future.value(res.data);
      }
      return Future.error("Giriş Başarısız.");
    } catch (onError) {
      return Future.error(onError);
    }
  }

  @override
  Future<bool> isPhoneInDatabase(String phoneNumber) async {
    try {
      var body = {"phone_number": phoneNumber};
      var res = await _dio.post(Constant.baseUrl + Constant.isPhoneInDatabase,
          data: body);
      if (res.statusCode == 200 && res.data["success"]) {
        return Future.value(res.data["isPhoneInDatabase"]);
      }
      return Future.value(false);
    } catch (onError) {
      return Future.value(false);
    }
  }

  @override
  Future<BaseResponse> register(RegisterModel registerModel) async {
    var response = await _dio.get("path");
    if (response.statusCode == 200) {
      return Future.value(BaseResponse.fromJson(jsonDecode(response.data)));
    }
    return Future.error(response.data);
  }

  @override
  Future<BaseResponse> help(Map<String, String> map) async {
    var res = await _dio
        .post(Constant.baseUrl + Constant.help, data: map)
        .catchError((onError) {
      return Future.error(onError);
    });
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(BaseResponse.fromJson(res.data));
    }
    return Future.error("Giriş Başarısız.");
  }
}
