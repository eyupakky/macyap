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
  late UserList myFollowers = UserList();
  late UserList followingUsers = UserList();

  Future<User> getMyUser() {
    return Future.value(iAccountRepository.getMyUser());
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
    if (followingUsers.users!.isEmpty) {
      followingUsers = await iAccountRepository.getFollowingUsers(search);
    }
    return followingUsers;
  }

  Future<UserList> getMyFollowers(String search) async {
    if (followingUsers.users!.isEmpty) {
      myFollowers = await iAccountRepository.getMyFollowers(search);
    }
    return myFollowers;
  }

  Future<BaseResponse> follow(int? id) async {
    var users = await iAccountRepository.follow(id);
    return users;
  }
}
