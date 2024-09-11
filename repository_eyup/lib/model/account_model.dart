import 'package:flutter/cupertino.dart';

class AccountModel {
  late String route;
  late String item;
  late IconData icon;
  late String? token;

  AccountModel(
      {required this.route,
      required this.item,
      required this.icon,
      this.token});

  AccountModel.fromJson(Map json) {
    route = json["route"];
    item = json["item"];
  }
}
