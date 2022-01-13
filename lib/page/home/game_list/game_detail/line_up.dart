import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/game_users.dart';

class LineUp extends StatelessWidget {
  int id;
  HomeController homeController;

  LineUp({Key? key, required this.id, required this.homeController})
      : super(key: key);
  bool katil = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GameUsers>(
          future: homeController.getGameUsers(id),
          builder: (context, snapshot) {
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
                          children: List.generate(myTeam!.length, (index) {
                            return Column(
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
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 12)),
                                Text(
                                  "${myTeam[index].favoritePosition == "" ? myTeam[index].favoritePosition : "Ayarlanmadı"}",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                Divider(),
                              ],
                            );
                          }),
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: List.generate(rivalTeam!.length, (index) {
                            return Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: const EdgeInsets.all(12),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: rivalTeam[index].userId != -1
                                        ? Image.network(
                                            '${rivalTeam[index].image}',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            '${rivalTeam[index].image}',
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                                Text("@${rivalTeam[index].username}",
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 12)),
                                Text(
                                  "${rivalTeam[index].favoritePosition == "" ? rivalTeam[index].favoritePosition : "Ayarlanmadı"}",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                Divider(),
                              ],
                            );
                          }),
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
              joinMatch(count, context);
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

  void joinMatch(count, context) {
    count
        ? homeController.joinGame(id).then((value) {
            if (value.success!) {
              context.read<ChangeBottomCubit>().changeFlushBar(false);
            } else {
              showToast('${value.description}');
            }
          })
        : homeController.quitGame(id).then((value) {
            if (value.success!) {
              context.read<ChangeBottomCubit>().changeFlushBar(true);
            } else {
              showToast('${value.description}');
            }
          });
  }
}
