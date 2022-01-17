import 'package:dio/src/dio.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/model/account_model.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/game_users.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/user.dart';
import 'package:repository_eyup/model/user_list.dart';

import '../constant.dart';

abstract class IAccountRepository {
  Future<User> getMyUser();

  Future<User> getUserProfile(int? id);

  Future<List<AccountModel>> getAccount(String id);

  Future<MatchesModel> getUsersAttendingMatchs(int? id);

  Future<MatchesModel> getUsersPlayedMatchs(int? id);

  Future<UserList> getMyFollowers(String? search);

  Future<UserList> getFollowingUsers(String? search);

  Future<BaseResponse> follow(int? id);

  Future<BaseResponse> updateEmail(String? newEmail, String? password);

  Future<BaseResponse> updatePassword(
      String? oldPass, String? newPass, String? newPassValid);
}

class AccountRepository extends IAccountRepository {
  Dio _dio;

  AccountRepository(this._dio);

  @override
  Future<List<AccountModel>> getAccount(String id) {
    return Future.value(getData());
  }

  List<AccountModel> getData() {
    List<AccountModel> list = [];
    list.add(AccountModel(
        route: "/profile",
        item: "Profile",
        icon: Icons.account_circle_outlined));
    list.add(AccountModel(
        route: "/followers", item: "Takipçi", icon: Icons.supervisor_account));
    list.add(AccountModel(
        route: "/wallet",
        item: "Cüzdan",
        icon: Icons.account_balance_wallet_rounded));
    list.add(
        AccountModel(route: "/setting", item: "Ayarlar", icon: Icons.settings));
    list.add(AccountModel(
        route: "/email", item: "Email güncelle", icon: Icons.email));
    list.add(AccountModel(
        route: "/password", item: "Şifre güncelleme", icon: Icons.password));
    list.add(AccountModel(
        route: "/exit", item: "Sign out", icon: Icons.exit_to_app));
    return list;
  }

  @override
  Future<User> getMyUser() async {
    var res = await _dio.post(Constant.baseUrl + Constant.getMyUser,
        data: {"access_token": Constant.accessToken});
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(User.fromJson(res.data));
    }
    return Future.error("Giriş Başarısız.");
  }

  @override
  Future<MatchesModel> getUsersAttendingMatchs(int? id) async {
    var res = await _dio.post(
        Constant.baseUrl + Constant.getUsersAttendingMatchs,
        data: {"access_token": Constant.accessToken, "user_id": id});
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(MatchesModel.fromJson(res.data));
    }
    return Future.error("Giriş Başarısız.");
  }

  @override
  Future<MatchesModel> getUsersPlayedMatchs(int? id) async {
    var res = await _dio.post(Constant.baseUrl + Constant.getUsersPlayedMatchs,
        data: {"access_token": Constant.accessToken, "user_id": id});
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(MatchesModel.fromJson(res.data));
    }
    return Future.error("Giriş Başarısız.");
  }

  @override
  Future<UserList> getMyFollowers(String? search) async {
    var res = await _dio.post(Constant.baseUrl + Constant.getMyFollowers,
        data: {
          "access_token": Constant.accessToken,
          "search": search
        }).catchError((err) {
      return Future.error(err);
    });
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(UserList.fromJson(res.data));
    }
    return Future.error("Giriş Başarısız.");
  }

  @override
  Future<UserList> getFollowingUsers(String? search) async {
    var res = await _dio.post(Constant.baseUrl + Constant.getFollowingUsers,
        data: {"access_token": Constant.accessToken, "search": search});
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(UserList.fromJson(res.data));
    }
    return Future.error("Giriş Başarısız.");
  }

  @override
  Future<BaseResponse> follow(int? id) async {
    var res = await _dio.post(Constant.baseUrl + Constant.follow, data: {
      "access_token": Constant.accessToken,
      "user_id": id
    }).catchError((onError) {
      return Future.error(onError);
    });
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(BaseResponse.fromJson(res.data));
    }
    return Future.error(res.data["description"]);
  }

  @override
  Future<User> getUserProfile(int? id) async {
    var res = await _dio.post(Constant.baseUrl + Constant.getUserProfile,
        data: {"access_token": Constant.accessToken, "user_id": id});
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(User.fromJson(res.data));
    }
    return Future.error("Giriş Başarısız.");
  }

  @override
  Future<BaseResponse> updateEmail(String? newEmail, String? password) async {
    var res = await _dio.post(Constant.baseUrl + Constant.updateEmail, data: {
      "access_token": Constant.accessToken,
      "new_email": newEmail,
      "password": password
    });
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(BaseResponse.fromJson(res.data));
    }
    return Future.error("Giriş Başarısız.");
  }

  @override
  Future<BaseResponse> updatePassword(
      String? oldPass, String? newPass, String? newPassValid) async {
    var res =
        await _dio.post(Constant.baseUrl + Constant.updatePassword, data: {
      "access_token": Constant.accessToken,
      "old_password": oldPass,
      "new_password_one": newPass,
      "new_password_two": newPassValid
    }).catchError((onError) {
      return Future.error(onError);
    });
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(BaseResponse.fromJson(res.data));
    }
    return Future.error(res.data["success"]);
  }
}
