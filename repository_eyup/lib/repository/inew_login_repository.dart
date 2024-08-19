// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/register_model.dart';

abstract class INewLoginRepository {
  Future<String> login(String phoneNumber);
  Future<BaseResponse> help(Map<String, String> map);
  Future<BaseResponse> register(RegisterModel registerModel);
}

class NewLoginRepository implements INewLoginRepository {
  late final Dio _dio;

  NewLoginRepository(this._dio);

  @override
  Future<String> login(String phoneNumber) async {
    Map<String, String> body = {"phone_number": phoneNumber};
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
