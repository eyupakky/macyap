import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/game_detail.dart';
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
  late String text="Maça Katıl";
  late BuildContext _context;
  late GameUsers users = GameUsers();

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: FutureBuilder<GameUsers>(
          future: widget.homeController.getGameUsers(widget.id),
          builder: (cnx, snapshot) {
            if (snapshot.data != null) {
              users = snapshot.data!;
              if(AppConfig.gameDetail.locked!){
                text="Maça katılma isteği gönder";
              }else{
                if((users.totalPlayers ==
                    (users.rivalTeamSize! + users.myTeamSize!))) {
                  text = "Maç Dolu";
                }else if(users.myCheck){
                  text="Maçtan Çık";
                }else{
                  text="Maça Katıl";
                }
              }
              var myListFiltered = snapshot.data!.allTeam!
                  .where((e) => e.userId == Constant.userId);
              if (myListFiltered.isEmpty) {
                context.read<ChangeBottomCubit>().changeFlushBar(true);
              } else {
                context.read<ChangeBottomCubit>().changeFlushBar(false);
              }
              List<Users>? myTeam = snapshot.data!.myTeam;
              List<Users>? rivalTeam = snapshot.data!.rivalTeam;
              return SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: list(myTeam, context,
                              "Açık Takım\n${snapshot.data!.myTeamSize} / ${myTeam!.length}"),
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: list(rivalTeam, context,
                              "Koyu Takım\n${snapshot.data!.rivalTeamSize} / ${rivalTeam!.length}"),
                        )),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: BlocBuilder<ChangeBottomCubit, bool>(
        builder: (context, count) => FlatButton(
            padding: const EdgeInsets.all(8),
            onPressed: () {
              if(AppConfig.gameDetail.locked!){
                joinGameRequest();
              }else{
                if(!users.myCheck){
                  joinMatch();
                }else{
                  quitGame();
                }
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            color:
                users.totalPlayers == (users.rivalTeamSize! + users.myTeamSize!)
                    ? Colors.grey
                    : !users.myCheck
                        ? Colors.green.withOpacity(0.9)
                        : Colors.red.withOpacity(0.9)),
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
                    style: const TextStyle(color: Colors.black87, fontSize: 12)),
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

  void joinMatch() {
     widget.homeController.joinGame(widget.id).then((value) {
            if (value.success!) {
              users.myCheck=true;
              context.read<GameFavorite>().changeFavorite(true);
              setState(() {});
            } else {
              showToast('${value.description}');
              if (value.description!.contains("bakiyeniz eksik")) {
                Navigator.pushNamed(context, "/wallet",
                    arguments: Constant.userId);
              }
            }
          });
  }
  void quitGame(){
    widget.homeController.quitGame(widget.id).then((value) {
      if (value.success!) {
        users.myCheck=false;
        context.read<GameFavorite>().changeFavorite(false);
        setState(() {});
      } else {
        showToast('${value.description}');
      }
    });
  }
}
