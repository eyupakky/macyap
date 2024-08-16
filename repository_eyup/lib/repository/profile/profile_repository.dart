// ignore_for_file: implementation_imports, prefer_final_fields, unused_field

import 'package:dio/src/dio.dart';

abstract class IProfileRepository {
  Future<String> getProfile(String id);
  Future<List<String>> getAttending(String id);
  Future<List<String>> getPlayed(String id);
}

class ProfileRepository extends IProfileRepository {
  Dio _dio;
  ProfileRepository(this._dio);

  @override
  Future<List<String>> getAttending(String id) {
    return Future.value([]);
  }

  @override
  Future<List<String>> getPlayed(String id) {
    return Future.value([]);
  }

  @override
  Future<String> getProfile(String id) {
    return Future.value("");
  }
}
