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
  int id;
  HomeController homeController;

  LineUp({Key? key, required this.id, required this.homeController})
      : super(key: key);

  @override
  State<LineUp> createState() => _LineUpState();
}

class _LineUpState extends State<LineUp> {
  bool katil = true;

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: FutureBuilder<GameUsers>(
          future: widget.homeController.getGameUsers(widget.id),
          builder: (cnx, snapshot) {
            if (snapshot.data != null) {
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
              joinMatch(count);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Text(
              count ? "Maça Katıl" : "Maçtan çık",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            color: count
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
          Navigator.pushNamed(context, '/profile',
              arguments: myTeam[index].userId);
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
            Text("@${myTeam[index].username}",
                style: const TextStyle(color: Colors.black87, fontSize: 12)),
            Text(
              "${myTeam[index].favoritePosition == "" ? myTeam[index].favoritePosition : "Ayarlanmadı"}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Divider(),
          ],
        ),
      );
    });
  }

  void joinMatch(count) {
    count
        ? widget.homeController.joinGame(widget.id).then((value) {
            if (value.success!) {
              setState(() {});
            } else {
              showToast('${value.description}');
            }
          })
        : widget.homeController.quitGame(widget.id).then((value) {
            if (value.success!) {
              setState(() {});
            } else {
              showToast('${value.description}');
            }
          });
  }
}
