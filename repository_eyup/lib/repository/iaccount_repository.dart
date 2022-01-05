import 'package:dio/src/dio.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/model/account_model.dart';

abstract class IAccountRepository {
  Future<List<AccountModel>> getAccount(String id);
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
        route: "/followers",
        item: "Takipçi",
        icon: Icons.supervisor_account));
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
}
