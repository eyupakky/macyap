import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/game_users.dart';

class LineUp extends StatefulWidget {
  HomeController homeController;
  int id;

  LineUp({Key? key, required this.homeController, required this.id})
      : super(key: key);

  @override
  State<LineUp> createState() => _LineUpState();
}

class _LineUpState extends State<LineUp> {
  bool katil = true;
  late String text = "";
  late BuildContext _context;
  late GameUsers users = GameUsers();
  late List<Users>? myTeam;
  late List<Users>? rivalTeam;

  @override
  void initState() {
    super.initState();
    getGetGameUsers();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: users.myTeamSize == -1
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: list(myTeam, context,
                            "Açık Takım\n${users.myTeamSize} / ${myTeam!.length}"),
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: list(rivalTeam, context,
                            "Koyu Takım\n${users.rivalTeamSize} / ${rivalTeam!.length}"),
                      )),
                ],
              ),
            ),
      bottomNavigationBar: BlocBuilder<ChangeBottomCubit, bool>(
        builder: (context, count) => MaterialButton(
            padding: const EdgeInsets.all(8),
            onPressed: () {
              if (AppConfig.gameDetail.locked!) {
                joinGameRequest();
              } else {
                if (!users.myCheck) {
                  joinMatch();
                } else {
                  _showDialog();
                  //quitGame();
                }
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
            child: Text(
              (users.totalPlayers == (users.rivalTeamSize! + users.myTeamSize!))
                  ? "Maç Dolu"
                  : ((users.myCheck) ? "Maçtan Çık" : "Maça Katıl"),
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            color: users.totalPlayers == users.totalCheckPlayers
                ? Colors.grey
                : users.myCheck
                    ? Colors.red.withOpacity(0.9)
                    : users.myTeamSize == -1
                        ? Colors.transparent
                        : Colors.green.withOpacity(0.9)),
      ),
    );
  }

  List<Widget> list(List<Users>? myTeam, context, String teamName) {
    List<Widget> list = [];
    list.add(SizedBox(
        height: 50,
        child: Center(
            child: Text(
          teamName,
          textAlign: TextAlign.center,
        ))));
    list.addAll(getItem(myTeam, context));
    return list;
  }

  List<Widget> getItem(List<Users>? myTeam, context) {
    return List.generate(myTeam!.length, (index) {
      return InkWell(
        onTap: () {
          if (myTeam[index].userId != -1) {
            Navigator.pushNamed(context, '/profile',
                arguments: myTeam[index].userId);
          }
        },
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: myTeam[index].userId != -1
                    ? Image.network(
                        '${myTeam[index].image}',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        '${myTeam[index].image}',
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            SizedBox(
              width: 125,
              child: Center(
                child: Text("@${myTeam[index].username}",
                    maxLines: 1,
                    style:
                        const TextStyle(color: Colors.black87, fontSize: 12)),
              ),
            ),
            Text(
              "${myTeam[index].favoritePosition == "" ? myTeam[index].favoritePosition : ""}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Divider(),
          ],
        ),
      );
    });
  }

  void joinGameRequest() {
    widget.homeController.joinGameRequest(widget.id).then((value) {
      if (value.success!) {
        setState(() {});
      } else {
        showToast('${value.description}');
      }
    }).catchError((onError) {
      showToast('$onError');
    });
  }

  _showDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(right: 10, left: 10),
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 18, bottom: 12),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      const Text(
                        "Maç saatine 6 saat kala ve daha önce yapılan iptal ve maçtan çıkış işlemlerinde maç ücreti hesabınıza geri yansıtılacak. Sonrasında ücret iadesi yapılamayacaktır. Maçtan çıkacaksınız! Emin misiniz ? ",
                        style: TextStyle(fontFamily: "Montserrat-normal"),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CupertinoButton(
                                child: const Text("İptal Et"),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          Expanded(
                            flex: 1,
                            child: CupertinoButton(
                                child: const Text("Onayla"),
                                onPressed: () {
                                  quitGame();
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  void joinMatch() {
    widget.homeController.joinGame(widget.id).then((value) {
      if (value.success!) {
        users.myCheck = true;
        context.read<GameFavorite>().changeFavorite(true);
        getGetGameUsers();
      } else {
        showToast('${value.description}');
        if (value.description!.contains("bakiyeniz eksik")) {
          Navigator.pushNamed(context, "/wallet", arguments: Constant.userId);
        }
      }
    });
  }

  void quitGame() {
    widget.homeController.quitGame(widget.id).then((value) {
      if (value.success!) {
        users.myCheck = false;
        context.read<GameFavorite>().changeFavorite(false);
        getGetGameUsers();
      } else {
        showToast('${value.description}');
      }
    });
  }

  void getGetGameUsers() {
    //widget.id
    widget.homeController.getGameUsers(widget.id).then((value) {
      users = value;
      if (AppConfig.gameDetail.locked!) {
        text = "Maça katılma isteği gönder";
      } else {
        if ((users.totalPlayers ==
            (users.rivalTeamSize! + users.myTeamSize!))) {
          text = "Maç Dolu";
        } else if (users.myCheck) {
          text = "Maçtan Çık";
        } else {
          text = "Maça Katıl";
        }
        var myListFiltered =
            value.allTeam!.where((e) => e.userId == Constant.userId);
        if (myListFiltered.isEmpty) {
          context.read<ChangeBottomCubit>().changeFlushBar(true);
        } else {
          context.read<ChangeBottomCubit>().changeFlushBar(false);
        }
        myTeam = value.myTeam;
        rivalTeam = value.rivalTeam;
      }
      setState(() {});
    });
  }
}
