import 'dart:io';

import 'package:dio/dio.dart';
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

  Future<BaseResponse> blockUser(int? id);

  Future<BaseResponse> removeBlockUser(int? id);

  Future<BaseResponse> updateEmail(String? newEmail, String? password);

  Future<BaseResponse> updateSetting(
      String? userName, String? name, String? lastName);

  Future<BaseResponse> uploadImage(String image);

  Future<bool> checkFollow(int? userId);

  Future<String> getMyRole();

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
        item: "Profil",
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
        route: "/email", item: "Email güncelleme", icon: Icons.email));
    list.add(AccountModel(
        route: "/password", item: "Şifre güncelleme", icon: Icons.password));
    list.add(AccountModel(
        route: "/exit", item: "Çıkış Yap", icon: Icons.exit_to_app));
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
  Future<BaseResponse> updateSetting(
      String? userName, String? name, String? lastName) async {
    var res = await _dio.post(Constant.baseUrl + Constant.settings, data: {
      "access_token": Constant.accessToken,
      "username": userName,
      "firstname": name,
      "lastname": lastName
    });
    BaseResponse _baseResponse = BaseResponse.fromJson(res.data);
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(_baseResponse);
    }
    return Future.value(_baseResponse);
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

  @override
  Future<bool> checkFollow(int? userID) async {
    var res = await _dio.post(Constant.baseUrl + Constant.checkFollow, data: {
      "access_token": Constant.accessToken,
      "user_id": userID,
    });
    return Future.value(res.data);
  }

  @override
  Future<BaseResponse> uploadImage(String image) async {
    var res = await _dio
        .post(Constant.baseUrl + Constant.updateImage, data:{"access_token": Constant.accessToken,
      "image": image})
        .catchError((onError) {
      return Future.error(onError);
    });
    BaseResponse _baseResponse = BaseResponse.fromJson(res.data);
    if (res.statusCode == 200 && res.data["success"]) {
      return Future.value(_baseResponse);
    }
    return Future.error(_baseResponse);
  }

  @override
  Future<String> getMyRole() async {
    var res = await _dio.post(Constant.baseUrl + Constant.getMyRole, data: {
      "access_token": Constant.accessToken,
    }).catchError((onError) {});
    if (res.data["success"]) {
      return Future.value(res.data["durum"]);
    } else {
      return Future.error(res.data["durum"]);
    }
  }

  @override
  Future<BaseResponse> blockUser(int? id) async{
    var res = await _dio.post(Constant.baseUrl + Constant.blockUser, data: {
      "access_token": Constant.accessToken,"blocked_user_id":id
    }).catchError((onError) {});
    if (res.data["success"]) {
      return Future.value(BaseResponse.fromJson(res.data));
    } else {
      return Future.error(BaseResponse.fromJson(res.data));
    }
  }

  @override
  Future<BaseResponse> removeBlockUser(int? id)async {
    var res = await _dio.post(Constant.baseUrl + Constant.removeBlockUser, data: {
      "access_token": Constant.accessToken,"blocked_user_id":id
    }).catchError((onError) {});
    if (res.data["success"]) {
      return Future.value(BaseResponse.fromJson(res.data));
    } else {
      return Future.error(BaseResponse.fromJson(res.data));
    }
  }
}
