// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/register_model.dart';

abstract class ILoginRepository {
  Future<String> login(String username, String password);
  Future<Map<String, dynamic>> loginWithPhone(String phoneNumber);
  Future<BaseResponse> help(Map<String, String> map);
  Future<Map<String, dynamic>> smsVerification(
      int code, int userId, String phone);
  Future<Map<String, dynamic>> phoneIsVerified(String token);
  Future<Map<String, dynamic>> phoneVerification(
      String phoneNumber, String token);

  Future<BaseResponse> register(RegisterModel registerModel);
}

class LoginRepository implements ILoginRepository {
  late final Dio _dio;

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
    Map<String, String> body = {"phone": phoneNumber.substring(3)};
    var res =
        await _dio.post(Constant.baseUrl + Constant.loginWithPhone, data: body);
    if (res.statusCode == 200 && res.data["isSuccess"]) {
      return Future.value(res.data);
    }
    return Future.error(res.data["message"]);
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

  @override
  Future<Map<String, dynamic>> smsVerification(
      int code, int userId, String phone) async {
    Map<String, dynamic> body = {
      "code": code,
      "userId": userId,
      "phone": phone
    };
    var res = await _dio.post(Constant.baseUrl + Constant.smsVerification,
        data: body);
    if (res.statusCode == 200 && res.data["isSuccess"]) {
      return Future.value(res.data);
    }
    return Future.error(res.data["message"]);
  }

  @override
  Future<Map<String, dynamic>> phoneIsVerified(String token) async {
    Map<String, String> body = {"token": token};
    var res = await _dio.post(Constant.baseUrl + Constant.phoneIsVerified,
        data: body);
    if (res.statusCode == 200) {
      return Future.value(res.data);
    }
    return Future.error(res.data["message"]);
  }

  @override
  Future<Map<String, dynamic>> phoneVerification(
      String phoneNumber, String token) async {
    Map<String, String> body = {
      "phone": phoneNumber.substring(3),
      "token": token
    };
    var res = await _dio.post(Constant.baseUrl + Constant.phoneVerification,
        data: body);
    if (res.statusCode == 200) {
      return Future.value(res.data);
    }

    if (res.statusCode == HttpStatus.badRequest) {
      String error = '';
      var errorList = res.data["errors"]["Phone"];
      errorList.forEach((element) {
        error += element + '\n';
      });

      return Future.error(error);
    }
    return Future.error(res.data["message"]);
  }
}
