import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/register_model.dart';

abstract class ILoginRepository{
  Future<String> login(String username,String password);
  Future<BaseResponse> register(RegisterModel registerModel);
}
class LoginResult implements ILoginRepository{
  late Dio _dio;
  LoginResult(this._dio);
  @override
  Future<String> login(String username, String password)async {
    var res =await _dio.get("path");
    var response = jsonDecode(res.data);
    if(response.statusCode==200 && response["succest"]){
      return Future.value(response["access_token"]);
    }
    return Future.error(response.data);
  }

  @override
  Future<BaseResponse> register(RegisterModel registerModel) async{
    var response =await _dio.get("path");
    if(response.statusCode==200){
      return Future.value(BaseResponse.fromJson(jsonDecode(response.data)));
    }
    return Future.error(response.data);
  }

}