import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/page/account/profile/profile_tab.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/model/user.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final AccountController _accountController = AccountController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder<User>(
            future: _accountController.getMyUser(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: Text("Profil yükleniyor..."),
                );
              }
              User? myUser = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    ListTile(
                      title: Text(
                        "${myUser!.firstname} ${myUser.lastname}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text("${myUser.username}"),
                      trailing: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "${myUser.image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                              text: '${myUser.followers}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                              children: [
                            const TextSpan(
                                text: "  Takipçi  ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                            TextSpan(
                                text: '${myUser.following}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const TextSpan(
                                text: "  Takip ettiğin",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ])),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                              text: '${myUser.manofthematch}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                              children: [
                            TextSpan(
                                text:
                                    "  Maçın oyuncusu %${myUser.realibility} güvenilirlik sağlar  ",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ])),
                    ),
                    SizedBox(
                        height: constraints.maxHeight * 0.75,
                        child:ProfileTab(user: myUser,)),
                  ],
                ),
              );
            });
      }),
    ));
  }
}
