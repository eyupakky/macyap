import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/widget/filter_drawer.dart';
import 'package:halisaha/widget/search_widget.dart';
import 'package:intl/intl.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/firebase_controller.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:halisaha/help/location_mixin.dart';
import 'game_list/home_list_item.dart';
class TurnuvaList extends StatefulWidget {
  const TurnuvaList({Key? key}) : super(key: key);

  @override
  State<TurnuvaList> createState() => _TurnuvaListState();
}

class _TurnuvaListState extends State<TurnuvaList> with LocationMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController _homeController = HomeController();
  final AccountController _accountController = AccountController();
  Map<String, String> map = {};
  final f = DateFormat('dd.MM.yyyy');
  List<Match> matchList = [];
  String filter = "";
  final FirebaseController _firebaseController = FirebaseController();

  @override
  void initState() {
    super.initState();
    getLocation().then((value) {
      if (value != null) {
        _firebaseController.sendLocation(value.latitude!, value.longitude!);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
            child: FilterDrawer(
          selectItem: filter,
          callBack: (val) {
            setState(() {
              Navigator.pop(context);
              filter = val;
            });
          },
        )),
        body: BaseWidget(
          child: LayoutBuilder(builder: (context, constraints) {
            return SafeArea(
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight - 165,
                    color: Colors.black.withAlpha(20),
                    child: BlocBuilder<GameFavorite, bool>(
                        builder: (context, count) {
                      return FutureBuilder<List<Match>>(
                          future: _homeController.getLazyMatches(map),
                          builder: (context, snapshot) {
                            if (snapshot.error == "Sonuc boş.") {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child:const Center(
                                  child: Text("Bir hata oluştu."),
                                ),
                              );
                            } else if (snapshot.data == null ||
                                snapshot.data!.isEmpty) {
                              EasyLoading.isShow ? EasyLoading.dismiss() : null;
                              return SizedBox(
                                height: 200,
                                child: Center(
                                    child: Column(
                                  children: [
                                    snapshot.data == null
                                        ? const CircularProgressIndicator()
                                        : const SizedBox(),
                                    Text(snapshot.data == null
                                        ? "Maç aranıyor..."
                                        : "Maç bulunmuyor..."),
                                  ],
                                )),
                              );
                            }
                            List<Match> list = filterFunc(snapshot.data);
                            var matches = list;
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  EasyLoading.isShow
                                      ? EasyLoading.dismiss()
                                      : null;
                                  return HomeListItem(matches[index]);
                                });
                          });
                    }),
                  )
                ],
              ),
            );
          }),
        ),
        floatingActionButton: FutureBuilder<String>(
            future: _accountController.getMyRole(),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data != "Organizator") {
                return SizedBox();
              }
              return FloatingActionButton.small(
                onPressed: () {
                  Navigator.pushNamed(context, "/createGame");
                },
                child: const Icon(Icons.add),
              );
            }),
      ),
    );
  }

  List<Match> filterFunc(List<Match>? list) {
    switch (filter) {
      case "EN DÜŞÜK ÜCRET":
        list!.sort((a, b) => a.gamePrice!.compareTo(b.gamePrice!));
        return list;
      case "EN YÜKSEK ÜCRET":
        list!.sort((a, b) => b.gamePrice!.compareTo(a.gamePrice!));
        return list;
      case "EN ERKEN SAAT":
        list!.sort((a, b) => a.date!.compareTo(b.date!));
        return list;
      case "EN GEÇ SAAT":
        list!.sort((a, b) => b.date!.compareTo(a.date!));
        return list;
      case "EN BOŞ MAÇ":
        list!.sort((a, b) => a.joinedGamers!.compareTo(b.joinedGamers!));
        return list;
      case "EN DOLU MAÇ":
        list!.sort((a, b) => b.joinedGamers!.compareTo(a.joinedGamers!));
        return list;
      default:
        return list!;
    }
  }
}
