// ignore_for_file: unused_field, prefer_final_fields

import 'package:dio/dio.dart';

abstract class ISettingsRepository {
  Future<String> getUser();
  Future<String> updateImage();
  Future<String> updateUser();
}

class SettingsRepository extends ISettingsRepository {
  late Dio _dio;
  SettingsRepository(this._dio);
  @override
  Future<String> getUser() {
    return Future.value("");
  }

  @override
  Future<String> updateImage() {
    throw UnimplementedError();
  }

  @override
  Future<String> updateUser() {
    throw UnimplementedError();
  }
}
