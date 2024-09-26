// ignore_for_file: invalid_return_type_for_catch_error, prefer_final_fields, avoid_print, body_might_complete_normally_catch_error, avoid_renaming_method_parameters

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/model/city_model.dart';
import 'package:repository_eyup/model/count_model.dart';

abstract class IRegisterRepository {
  Future<List<Cities>> getCities();

  Future<List<Counties>> getCounties(int cityId);

  Future<Map<String, dynamic>> register(Map<String, dynamic> map);
}

class RegisterRepository extends IRegisterRepository {
  late Dio _dio;

  RegisterRepository(this._dio);

  @override
  Future<List<Cities>> getCities() async {
    var res =
        await _dio.get(Constant.baseUrl + Constant.getCities).catchError((err) {
      return Future.error("Şehir listesi yüklenemedi.");
    });
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(CityModel.fromJson(res.data).cities);
    } else {
      return Future.error("Şehir listesi yüklenemedi.");
    }
  }

  @override
  Future<List<Counties>> getCounties(int cityId) async {
    var res = await _dio.post(Constant.baseUrl + Constant.getCounties,
        data: {"city_id": cityId}).catchError((onError) {
      print(onError);
    });
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(CountiesModel.fromJson(res.data).counties);
    } else {
      return Future.error("İlçe listesi yüklenemedi.");
    }
  }

  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> body) async {
    print(jsonEncode(body));
    try {
      var res =
          await _dio.post(Constant.baseUrl + Constant.registerNew, data: body);

      if (res.statusCode == 200) {
        return Future.value(res.data);
      } else {
        return Future.error("Kayıt olurken bir hata oluştu.");
      }
    } catch (error) {
      if (error is DioError) {
        var errorData = error.response?.data;

        Map<String, dynamic> value = errorData['errors'];
        String errorText = '';

        value.forEach((key, val) {
          errorText += val.toString() + '\n';
        });

        if (errorText.isNotEmpty) {
          return Future.error(errorText);
        } else {
          return Future.error("Bilinmeyen bir hata oluştu.");
        }
      } else {
        return Future.error("Bilinmeyen bir hata oluştu.");
      }
    }
  }
}
