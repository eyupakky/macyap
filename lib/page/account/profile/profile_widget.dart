// ignore_for_file: must_be_immutable, invalid_return_type_for_catch_error, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/account/profile/profile_tab.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/model/user.dart';

class ProfileWidget extends StatefulWidget {
  User myUser;
  AccountController controller;

  ProfileWidget({required this.myUser, Key? key, required this.controller})
      : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: widget.controller.checkFollow(widget.myUser.userId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("Yükleniyor"),
            );
          }
          return Column(
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
                  "${widget.myUser.firstname} ${widget.myUser.lastname}",
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text("${widget.myUser.username}"),
                trailing: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "${widget.myUser.image}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ListTile(
                  title: Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width *
                    (widget.myUser.userId != Constant.userId ? 0.50 : 0.30),
                child: Row(
                  children: [
                    Expanded(
                      child: Visibility(
                        visible: widget.myUser.userId != Constant.userId,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/messageDetails",
                                arguments: widget.myUser.userId);
                          },
                          child: const Text("Mesaj At",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 10,
                                  fontFamily: "Montserrat-normal")),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: OutlinedButton(
                          onPressed: snapshot.data!
                              ? null
                              : () {
                                  widget.controller
                                      .follow(widget.myUser.userId)
                                      .then((value) {
                                    setState(() {
                                      showToast('${value.description}',
                                          color: Colors.green);
                                    });
                                  }).catchError((err) => showToast('$err'));
                                },
                          child: Text(
                              snapshot.data! ? "Takip ediliyor" : "Takip Et",
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 10,
                                  fontFamily: "Montserrat-normal")),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: OutlinedButton(
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return widget.myUser.blocked!
                                ? Colors.red
                                : Colors.transparent;
                          })),
                          onPressed: snapshot.data!
                              ? null
                              : () {
                                  EasyLoading.show();
                                  widget.myUser.blocked!
                                      ? widget.controller
                                          .removeBlockUser(widget.myUser.userId)
                                          .then((value) {
                                          setState(() {
                                            widget.myUser.blocked = false;
                                            EasyLoading.dismiss();
                                            showToast(
                                                "Engelleme kaldırıldı...");
                                          });
                                        }).catchError((onError) {
                                          EasyLoading.dismiss();
                                          showToast(onError);
                                        })
                                      : widget.controller
                                          .blockUser(widget.myUser.userId)
                                          .then((value) {
                                          setState(() {
                                            widget.myUser.blocked = true;
                                            EasyLoading.dismiss();
                                            showToast("Engelleme başarılı...");
                                          });
                                        }).catchError((onError) {
                                          EasyLoading.dismiss();
                                          showToast(onError);
                                        });
                                },
                          child: Text(
                              widget.myUser.blocked!
                                  ? "Engeli Kaldır"
                                  : "Engelle",
                              style: TextStyle(
                                  color: widget.myUser.blocked!
                                      ? Colors.white
                                      : Colors.red,
                                  fontSize: 10,
                                  fontFamily: "Montserrat-normal")),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  // : FlatButton(
                  //     color: Colors.redAccent,
                  //     onPressed: () {},
                  //     child: const Text(
                  //       "Takipten çıkar",
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontFamily: "Montserrat-normal"),
                  //     )),

                  ),
              Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
              RichText(
                  text: TextSpan(
                      text: '${widget.myUser.followers}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 13),
                      children: [
                    const TextSpan(
                        text: "  Takipçi  ",
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: '${widget.myUser.following}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text: "  Takip ettiğin",
                        style: TextStyle(color: Colors.grey)),
                  ])),
              Container(
                margin: const EdgeInsets.only(top: 12, left: 15),
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                        text: '${widget.myUser.manofthematch}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13),
                        children: [
                      TextSpan(
                          text:
                              "  Maçın oyuncusu %${widget.myUser.realibility} güvenilirlik sağlar  ",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.grey)),
                    ])),
              ),
              Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: ProfileTab(user: widget.myUser)),
            ],
          );
        });
  }
}
