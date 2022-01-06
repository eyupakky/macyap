import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/model/matches_model.dart';

abstract class IMatchesRepository {
  Future<List<Match>> getLazyMatches(Map<String, String> search);

  Future<Match> getMatch(String id);
}

class MatchesRepository extends IMatchesRepository {
  Dio _dio;

  MatchesRepository(this._dio);

  @override
  Future<List<Match>> getLazyMatches(Map<String, String> search) async {
    search.putIfAbsent("access_token", () => Constant.accessToken);
    var response = await _dio.post(Constant.baseUrl + Constant.getGamesNoFilter,
        data:search).catchError((err){
          print(err);
    });
    MatchesModel model = MatchesModel.fromJson(response.data);
    return Future.value(model.match);
  }

  @override
  Future<Match> getMatch(String id) {
    // TODO: implement getMatche
    throw UnimplementedError();
  }
}
