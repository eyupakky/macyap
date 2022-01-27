import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/comment.dart';
import 'package:repository_eyup/model/create_game.dart';
import 'package:repository_eyup/model/game_detail.dart';
import 'package:repository_eyup/model/game_users.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/repository/imatches_repository.dart';

class HomeController {
  IMatchesRepository iMatchesRepository = MatchesRepository(Dio());

  // Map<String, List<Match>> matchesList = {};
  late bool temp = true;
  List<Match> matches = [];
  Map<int, GameDetail> gameMap = {};

  Future<List<Match>> getLazyMatches(Map<String, String> map) async {
    // String? tarih = map["tarih"];
    /* && matchesList[tarih]==null */
      var response = await iMatchesRepository.getLazyMatches(map).catchError((err){
        temp = true;
      });
      matches = response;
      return Future.value(matches);
  }

  Future<GameDetail> getGameDetail(int id) async {
    var response;
    if (temp) {
      temp = false;
      if (gameMap[id] == null) {
        response = await iMatchesRepository.getMatchDetails(id);
        gameMap[id]=response;
      } else {
        response = gameMap[id];
      }
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }
  Future<GameUsers> getGameUsers(int id) async {
    if (temp) {
      temp = false;
      var response = await iMatchesRepository.getGameUsers(id,gameMap[id]!.limit);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }
  Future<Comment> getGameComment(int id) async {
    if (temp) {
      temp = false;
      var response = await iMatchesRepository.getGameComment(id);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }
  Future<BaseResponse> sendComment(String comment,int? gameId)async{
    if (temp) {
      temp = false;
      var response = await iMatchesRepository.writeGameComment(comment,gameId);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }
  Future<BaseResponse> joinGame(int? gameId)async{
    if (temp) {
      temp = false;
      var response = await iMatchesRepository.joinGame(gameId);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }
  Future<BaseResponse> quitGame(int? gameId)async{
    if (temp) {
      temp = false;
      var response = await iMatchesRepository.quitGame(gameId);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }
  Future<BaseResponse>createGame(CreateGame game)async{
    var response = await iMatchesRepository.createGame(game);
    return Future.value(response);
  }
}
