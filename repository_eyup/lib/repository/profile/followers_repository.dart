// ignore_for_file: implementation_imports, unused_field, prefer_final_fields

import 'package:dio/src/dio.dart';

abstract class IFollowersRepository {
  Future<List<String>> getFollowersList();
  Future<List<String>> getFollowingList();
  Future<List<String>> getBlockedLis();
}

class FollowersRepository extends IFollowersRepository {
  Dio _dio;
  FollowersRepository(this._dio);
  @override
  Future<List<String>> getBlockedLis() {
    return Future.value([]);
  }

  @override
  Future<List<String>> getFollowersList() {
    return Future.value([]);
  }

  @override
  Future<List<String>> getFollowingList() {
    return Future.value([]);
  }
}
