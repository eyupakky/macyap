import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/user.dart';

class AttendedPage extends StatelessWidget {
  User user;
  AttendedPage({Key? key, required this.user}) : super(key: key);
  final AccountController _accountController = AccountController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MatchesModel>(
        future: _accountController.getUsersPlayedMatchs(user.userId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("Oynadığım maçlar yükleniyor..."),
            );
          } else if (snapshot.data!.match!.isEmpty) {
            return const Center(
              child: Text("Oynadığım maç yok."),
            );
          }
          var matches = snapshot.data;
          return ListView.separated(
            itemCount: matches!.match!.length,
            itemBuilder: (context, index) {
              EasyLoading.isShow ? EasyLoading.dismiss() : null;
              Match match = matches.match![index];
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/gameDetail",arguments: match);
                },
                title: Text('${match.name}',style: const TextStyle(fontSize: 14),),
                subtitle: Text('${match.date}'),
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
