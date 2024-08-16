// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/model/game_users.dart';
import 'package:repository_eyup/model/user_list.dart';

class FollowersTabPage extends StatelessWidget {
  FollowersTabPage({Key? key}) : super(key: key);
  final AccountController _accountController = AccountController();
  String search = "";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserList>(
        future: _accountController.getMyFollowers(search),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("Takipçiler yükleniyor..."),
            );
          }
          if (snapshot.data!.users!.isEmpty) {
            return const Center(
              child: Text("Takipçi bulunamadı..."),
            );
          }
          var userList = snapshot.data;
          return ListView.separated(
            itemCount: userList!.users!.length,
            itemBuilder: (context, index) {
              EasyLoading.isShow ? EasyLoading.dismiss() : null;
              Users user = userList.users![index];
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/profile',
                      arguments: userList.users![index].userId);
                },
                leading: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "${user.image}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  '@${user.username}',
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              );
            },
          );
        });
  }
}
