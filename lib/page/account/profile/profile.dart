import 'package:flutter/material.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/page/account/profile/profile_widget.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/model/user.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final AccountController _accountController = AccountController();

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
        body: SafeArea(
      child: BaseWidget(
        child: SingleChildScrollView(
          child: FutureBuilder<User>(
              future: _accountController.getUserProfile(id),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Profil yükleniyor..."),
                  );
                }
                User myUser = snapshot.data!;
                return ProfileWidget(
                    myUser: myUser, controller: _accountController);
              }),
        ),
      ),
    ));
  }
}
