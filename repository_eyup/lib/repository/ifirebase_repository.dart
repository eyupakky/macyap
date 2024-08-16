// ignore_for_file: prefer_final_fields, avoid_print, body_might_complete_normally_catch_error

import 'package:dio/dio.dart';
import 'package:repository_eyup/constant.dart';

abstract class IFirebaseRepository {
  Future<bool> sendGuid(String guid);
  Future<bool> sendLocation(double locationX, double locationY);
}

class FirebaseRepository extends IFirebaseRepository {
  Dio _dio;

  FirebaseRepository(this._dio);

  @override
  Future<bool> sendGuid(String guid) async {
    var res = await _dio.post(Constant.baseUrl + Constant.sendGuid,
        data: {"access_token": Constant.accessToken, "guid": guid});
    if (res.statusCode == 200 && res.data) {
      return Future.value(true);
    }
    return Future.error("Bildirim hatası oluştu.");
  }

  @override
  Future<bool> sendLocation(double locationX, double locationY) async {
    var res = await _dio.post(Constant.baseUrl + Constant.sendLocation, data: {
      "access_token": Constant.accessToken,
      "location_x": '$locationX',
      "location_y": '$locationY'
    }).catchError((onError) {
      print(onError);
    });
    if (res.statusCode == 200 && res.data) {
      return Future.value(true);
    }
    return Future.error("Bildirim hatası oluştu.");
  }
}
