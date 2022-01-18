import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/comment.dart';
import 'package:repository_eyup/model/game_detail.dart';
import 'package:repository_eyup/model/game_users.dart';
import 'package:repository_eyup/model/matches_model.dart';

abstract class IMatchesRepository {
  Future<List<Match>> getLazyMatches(Map<String, String> search);

  Future<GameDetail> getMatchDetails(int id);

  Future<GameUsers> getGameUsers(int id, int? limit);

  Future<Comment> getGameComment(int? id);

  Future<BaseResponse> writeGameComment(String comment, int? id);

  Future<BaseResponse> joinGame(int? id);

  Future<BaseResponse> quitGame(int? id);
}

class MatchesRepository extends IMatchesRepository {
  Dio _dio;

  MatchesRepository(this._dio);

  @override
  Future<List<Match>> getLazyMatches(Map<String, String> search) async {
    search.putIfAbsent("access_token", () => Constant.accessToken);
    var response = await _dio
        .post(Constant.baseUrl + Constant.getGamesNoFilter, data: search)
        .catchError((err) {
      Future.error(err);
    });
    MatchesModel model = MatchesModel.fromJson(response.data);
    return Future.value(model.match);
  }

  @override
  Future<GameDetail> getMatchDetails(int id) async {
    var response = await _dio.post(Constant.baseUrl + Constant.getGameDetail,
        data: {
          "access_token": Constant.accessToken,
          "game_id": id
        }).catchError((err) {
      print(err);
    });
    return Future.value(GameDetail.fromJson(response.data));
  }

  @override
  Future<GameUsers> getGameUsers(int id, int? limit) async {
    var response = await _dio.post(Constant.baseUrl + Constant.getGameUsers,
        data: {
          "access_token": Constant.accessToken,
          "game_id": id
        }).catchError((err) {
      print(err);
    });
    return Future.value(GameUsers.fromJson(response.data, limit));
  }

  @override
  Future<Comment> getGameComment(int? id) async {
    var response = await _dio.post(Constant.baseUrl + Constant.getGameComments,
        data: {
          "access_token": Constant.accessToken,
          "game_id": id
        }).catchError((err) {
      print(err);
    });
    return Future.value(Comment.fromJson(response.data));
  }

  @override
  Future<BaseResponse> writeGameComment(String comment, int? id) async {
    var response = await _dio.post(Constant.baseUrl + Constant.writeGameComment,
        data: {
          "access_token": Constant.accessToken,
          "game_id": id,
          "comment": comment
        }).catchError((err) {
      print(err);
    });
    return Future.value(BaseResponse.fromJson(response.data));
  }

  @override
  Future<BaseResponse> joinGame(int? id) async {
    var response = await _dio.post(Constant.baseUrl + Constant.joinGame, data: {
      "access_token": Constant.accessToken,
      "game_id": id,
    }).catchError((err) {
      print(err);
    });
    return Future.value(BaseResponse.fromJson(response.data));
  }

  @override
  Future<BaseResponse> quitGame(int? id) async {
    var response = await _dio.post(Constant.baseUrl + Constant.quitGame, data: {
      "access_token": Constant.accessToken,
      "game_id": id,
    }).catchError((err) {
      print(err);
    });
    return Future.value(BaseResponse.fromJson(response.data));
  }
}
