import 'dart:io';

import 'package:dio/dio.dart';
import 'package:repository_eyup/model/account_model.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/game_users.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/user.dart';
import 'package:repository_eyup/model/user_list.dart';
import 'package:repository_eyup/repository/iaccount_repository.dart';

class AccountController {
  IAccountRepository iAccountRepository = AccountRepository(Dio());
  late List<AccountModel> _accountModel;
  late UserList _myFollowers = UserList();
  late UserList _followingUsers = UserList();

  Future<User> getMyUser() {
    return Future.value(iAccountRepository.getMyUser());
  }
  Future<User> getUserProfile(int? id) {
    return Future.value(iAccountRepository.getUserProfile(id));
  }
  Future<List<AccountModel>> getAccount(String id) async {
    _accountModel = await iAccountRepository.getAccount(id);
    return _accountModel;
  }

  Future<MatchesModel> getUsersAttendingMatchs(int? id) async {
    var _matchModel = await iAccountRepository.getUsersAttendingMatchs(id);
    return _matchModel;
  }

  Future<MatchesModel> getUsersPlayedMatchs(int? id) async {
    var _matchModel = await iAccountRepository.getUsersPlayedMatchs(id);
    return _matchModel;
  }

  Future<UserList> getFollowingUsers(String search) async {
    if (_followingUsers.users!.isEmpty) {
      _followingUsers = await iAccountRepository.getFollowingUsers(search);
    }
    return _followingUsers;
  }

  Future<UserList> getMyFollowers(String search) async {
    if (_myFollowers.users!.isEmpty) {
      _myFollowers = await iAccountRepository.getMyFollowers(search);
    }
    return _myFollowers;
  }

  Future<BaseResponse> follow(int? id) async {
    var users = await iAccountRepository.follow(id);
    return users;
  }
  Future<BaseResponse> updateEmail(String? newEmail,String? password) async {
    var users = await iAccountRepository.updateEmail(newEmail,password);
    return users;
  }
  Future<BaseResponse> updatePassword(String? oldPass,String? newPass,String? newPassValid) async {
    var users = await iAccountRepository.updatePassword(oldPass,newPass,newPassValid);
    return users;
  }
  Future<BaseResponse> updateSetting(String? userName, String? name,String? lastName) async {
    var users = await iAccountRepository.updateSetting(userName,name,lastName);
    return users;
  }
  Future<BaseResponse> updateImage(String image) async {
    var users = await iAccountRepository.uploadImage(image);
    return users;
  }
  Future<bool> checkFollow(int? userId) async {
    var res = await iAccountRepository.checkFollow(userId);
    return res;
  }
  Future<String> getMyRole() async {
    var res = await iAccountRepository.getMyRole();
    return res;
  }
}
