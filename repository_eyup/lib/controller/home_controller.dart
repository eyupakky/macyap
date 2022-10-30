import 'package:dio/dio.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/comment.dart';
import 'package:repository_eyup/model/create_game.dart';
import 'package:repository_eyup/model/game_detail.dart';
import 'package:repository_eyup/model/game_users.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/text_model.dart';
import 'package:repository_eyup/model/turnuva_list.dart';
import 'package:repository_eyup/repository/imatches_repository.dart';

class HomeController {
  IMatchesRepository _iMatchesRepository = MatchesRepository(Dio());

  // Map<String, List<Match>> matchesList = {};
  late bool temp = true;
  List<Match> matches = [];
  Map<int, GameDetail> gameMap = {};

  Future<List<Match>> getLazyMatches(Map<String, String> map) async {
    // String? tarih = map["tarih"];
    /* && matchesList[tarih]==null */
    getTurnuvalar();
    return _iMatchesRepository.getLazyMatches(map);

    var response =
        await _iMatchesRepository.getLazyMatches(map).catchError((err) {
      temp = true;
    });
    matches = response;
    return Future.value(matches);
  }

  Future<GameDetail> getGameDetail(int id) async {
    var response;
    response = await _iMatchesRepository.getMatchDetails(id);
    gameMap[id] = response;
    return Future.value(response);
  }

  Future<GameUsers> getGameUsers(int id) async {
    if (temp) {
      temp = false;
      var response =
          await _iMatchesRepository.getGameUsers(id, gameMap[id]!.limit);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }

  Future<Comment> getGameComment(int id) async {
    if (temp) {
      temp = false;
      var response = await _iMatchesRepository.getGameComment(id);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }

  Future<BaseResponse> sendComment(String comment, int? gameId) async {
    if (temp) {
      temp = false;
      var response =
          await _iMatchesRepository.writeGameComment(comment, gameId);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }

  Future<BaseResponse> joinGame(int? gameId) async {
    if (temp) {
      temp = false;
      var response = await _iMatchesRepository.joinGame(gameId);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }

  Future<BaseResponse> joinGameRequest(int? gameId) {
    return _iMatchesRepository.joinGameRequest(gameId);
  }

  Future<BaseResponse> quitGame(int? gameId) async {
    if (temp) {
      temp = false;
      var response = await _iMatchesRepository.quitGame(gameId);
      temp = true;
      return Future.value(response);
    } else {
      return Future.value(null);
    }
  }

  Future<BaseResponse> createGame(CreateGame game) async {
    var response = await _iMatchesRepository.createGame(game);
    return Future.value(response);
  }

  Future<bool> resetMyPassword(String usernameEmail, String code) async {
    var response =
        await _iMatchesRepository.resetMyPassword(usernameEmail, code);
    return Future.value(response);
  }

  Future<bool> lostMyPassword(String usernameEmail) async {
    var response = await _iMatchesRepository.lostMyPassword(usernameEmail);
    return Future.value(response);
  }

  Future<TurnuvaListModel> getTurnuvalar() async {
    return await _iMatchesRepository.getTurnuvalar();
  }
  Future<BaseResponse2> joinTurnuva(String id) async {
    return await _iMatchesRepository.joinTurnuva(id);
  }
  Future<TextModel> getText() async {
    return await _iMatchesRepository.getText();
  }
}
