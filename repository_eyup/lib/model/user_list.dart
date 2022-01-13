import 'game_users.dart';

class UserList{
  bool? success;
  List<Users>? users = <Users>[];
  UserList();
  UserList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['value'] != null) {
      json['value'].forEach((v) {
        Users user = Users.fromJson(v);
        users!.add(user);
      });
    }
  }
}