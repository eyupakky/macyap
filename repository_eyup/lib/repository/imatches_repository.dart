import 'package:dio/dio.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/comment.dart';
import 'package:repository_eyup/model/create_game.dart';
import 'package:repository_eyup/model/game_detail.dart';
import 'package:repository_eyup/model/game_users.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/text_model.dart';
import 'package:repository_eyup/model/turnuva_list.dart';

abstract class IMatchesRepository {
  Future<List<Match>> getLazyMatches(Map<String, String> search);

  Future<GameDetail> getMatchDetails(int id);

  Future<GameUsers> getGameUsers(int id, int? limit);

  Future<Comment> getGameComment(int? id);

  Future<BaseResponse> writeGameComment(String comment, int? id);

  Future<BaseResponse> joinGame(int? id);

  Future<BaseResponse> joinGameRequest(int? id);

  Future<BaseResponse> quitGame(int? id);

  Future<BaseResponse> createGame(CreateGame game);

  Future<bool> lostMyPassword(String usernameEmail);

  Future<TurnuvaListModel> getTurnuvalar();

  Future<BaseResponse2> joinTurnuva(String id);

  Future<TextModel> getText();

  Future<BaseResponse2> getSmsOnayKontrol();

  Future<BaseResponse2> sendPhoneNumber(String phoneNumber);

  Future<BaseResponse2> smsKontrol(String code);

  Future<bool> resetMyPassword(String passsword, String code);
}

class MatchesRepository extends IMatchesRepository {
  Dio _dio;

  MatchesRepository(this._dio);

  @override
  Future<List<Match>> getLazyMatches(Map<String, String> search) async {
    search.putIfAbsent("access_token", () => Constant.accessToken);
    var response = await _dio
        .post(Constant.testBaseUrl + Constant.getGamesNoFilter, data: search)
        .catchError((err) {
      return Future.error(err);
    });
    MatchesModel model = MatchesModel.fromJson(response.data);
    if (model.success!) {
      return Future.value(model.match);
    } else {
      return Future.error("Sonuc boş.");
    }
  }

  @override
  Future<GameDetail> getMatchDetails(int id) async {
    var response = await _dio.post(Constant.baseUrl + Constant.getGameDetail,
        data: {
          "access_token": Constant.accessToken,
          "game_id": id
        }).catchError((err) {
      return Future.error(err);
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

  @override
  Future<BaseResponse> createGame(CreateGame game) async {
    game.accessToken = Constant.accessToken;
    var response = await _dio
        .post(Constant.baseUrl + Constant.createGame, data: game.toJson())
        .catchError((err) {
      return Future.error(err);
    });
    return Future.value(BaseResponse.fromJson(response.data));
  }

  @override
  Future<BaseResponse> joinGameRequest(int? id) async {
    var response =
        await _dio.post(Constant.baseUrl + Constant.joinGameRequest, data: {
      "access_token": Constant.accessToken,
      "game_id": id,
    }).catchError((err) {
      print(err);
    });
    return Future.value(BaseResponse.fromJson(response.data));
  }

  @override
  Future<bool> lostMyPassword(String usernameEmail) async {
    var response =
        await _dio.post(Constant.baseUrl + Constant.lostMyPassword, data: {
      "username_email": usernameEmail,
    }).catchError((err) {
      return Future.error(err);
    });
    if (response.statusCode == 200) {
      return Future.value(response.data);
    }
    return Future.error("Hata oluştu");
  }

  @override
  Future<bool> resetMyPassword(String passsword, String code) async {
    var response =
        await _dio.post(Constant.baseUrl + Constant.resetMyPassword, data: {
      "password": passsword,
      "code": code,
    }).catchError((err) {
      return Future.error(err);
    });
    if (response.statusCode == 200) {
      return Future.value(response.data);
    }
    return Future.error("Hata oluştu");
  }

  @override
  Future<TurnuvaListModel> getTurnuvalar() async {
    var response = await _dio.post(Constant.baseUrl + Constant.turnuvaList,
        data: {"access_token": Constant.accessToken}).catchError((err) {
      return Future.error(err);
    });
    if (response.statusCode == 200) {
      return Future.value(TurnuvaListModel.fromJson(response.data));
    }
    return Future.error("Hata oluştu");
  }

  @override
  Future<BaseResponse2> joinTurnuva(String id) async {
    var response = await _dio.post(Constant.baseUrl + Constant.joinTurnuva,
        data: {
          "access_token": Constant.accessToken,
          "turnuva_id": int.parse(id)
        }).catchError((err) {
      return Future.error(err);
    });
    if (response.statusCode == 200) {
      return Future.value(BaseResponse2.fromJson(response.data));
    }
    return Future.error("Hata oluştu");
  }

  @override
  Future<TextModel> getText() async {
    var response = await _dio.post(Constant.baseUrl + Constant.textList,
        data: {"access_token": Constant.accessToken}).catchError((err) {
      return Future.error(err);
    });
    if (response.statusCode == 200) {
      return Future.value(TextModel.fromJson(response.data));
    }
    return Future.error("Hata oluştu");
  }

  @override
  Future<BaseResponse2> getSmsOnayKontrol() async {
    var response = await _dio.post(
        Constant.testBaseUrl + Constant.smsOnayKontrol,
        data: {"access_token": Constant.accessToken}).catchError((err) {
      return Future.error(err);
    });
    if (response.statusCode == 200) {
      return Future.value(BaseResponse2.fromJson(response.data));
    }
    return Future.error("Hata oluştu");
  }

  @override
  Future<BaseResponse2> sendPhoneNumber(String phoneNumber) async {
    var response = await _dio
        .post(Constant.testBaseUrl + Constant.smsGonderPopup, data: {
      "access_token": Constant.accessToken,
      "gsm": phoneNumber
    }).catchError((err) {
      return Future.error(err);
    });
    if (response.statusCode == 200) {
      return Future.value(BaseResponse2.fromJson(response.data));
    }
    return Future.error("Hata oluştu");
  }

  @override
  Future<BaseResponse2> smsKontrol(String code) async {
    var response = await _dio
        .post(Constant.testBaseUrl + Constant.smsKontrolPopup, data: {
      "access_token": Constant.accessToken,
      "kod": code
    }).catchError((err) {
      return Future.error(err);
    });
    if (response.statusCode == 200) {
      return Future.value(BaseResponse2.fromJson(response.data));
    }
    return Future.error("Hata oluştu");
  }
}
