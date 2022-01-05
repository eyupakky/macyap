import 'package:dio/src/dio.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/venues_model.dart';

abstract class IFollowersRepository{
  Future<List<String>> getFollowersList();
  Future<List<String>> getFollowingList();
  Future<List<String>> getBlockedLis();
}

class FollowersRepository extends IFollowersRepository{
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