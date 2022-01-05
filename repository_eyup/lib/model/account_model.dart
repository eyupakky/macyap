
import 'package:flutter/cupertino.dart';

class AccountModel {
  late String route;
  late String item;
  late IconData icon;

  AccountModel(
      {required this.route,
      required this.item,required this.icon});

  AccountModel.fromJson(Map json) {
    route = json["route"];
    item = json["item"];
  }
}
