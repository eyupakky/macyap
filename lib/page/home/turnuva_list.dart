import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/filter_drawer.dart';
import 'package:halisaha/widget/search_widget.dart';
import 'package:intl/intl.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/firebase_controller.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:halisaha/help/location_mixin.dart';
import 'package:repository_eyup/model/turnuva_list.dart';
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
                    height: constraints.maxHeight,
                    color: Colors.black.withAlpha(20),
                    child: BlocBuilder<GameFavorite, bool>(
                        builder: (context, count) {
                      return FutureBuilder<TurnuvaListModel>(
                          future: _homeController.getTurnuvalar(),
                          builder: (context, snapshot) {
                            if (snapshot.error == "Sonuc boş.") {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: Text("Bir hata oluştu."),
                                ),
                              );
                            } else if (snapshot.data == null) {
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
                                        ? "Turnuvalar aranıyor..."
                                        : "Turnuva bulunmuyor..."),
                                  ],
                                )),
                              );
                            }
                            return ListView.builder(
                                itemCount: snapshot.data!.turnuvalar?.length,
                                itemBuilder: (context, index) {
                                  EasyLoading.isShow
                                      ? EasyLoading.dismiss()
                                      : null;
                                  return Card(
                                    child: Column(
                                      children: [
                                        Image.network(
                                          "https://macyap.com.tr/Content/Turnuva/İmg/${snapshot.data!.turnuvalar?[index].img}",
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 8, top: 4),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${snapshot.data!.turnuvalar?[index].turnuvaName}",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )),
                                        Html(
                                          data: snapshot.data!
                                              .turnuvalar?[index].aciklama,
                                          style: {
                                            "p": Style(
                                              color: Colors.black,
                                              fontSize: FontSize.small,
                                            )
                                          },
                                        ),
                                        MaterialButton(
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.all(8),
                                            onPressed: () {
                                              joinTurnuva(snapshot
                                                  .data!.turnuvalar?[index].id);
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(1)),
                                            child: Text(
                                              "${snapshot.data!.turnuvalar?[index].kBedeli}₺ Turnuvaya Katıl",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            color: Colors.green),
                                        Padding(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Katılımcı Sayısı : ${snapshot.data!.turnuvalar?[index].kAdet}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Text(
                                                "${snapshot.data!.turnuvalar?[index].tBaslangic!.split("T")[0]} - "
                                                "${snapshot.data!.turnuvalar?[index].tBitis!.split("T")[0]}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        )
                                      ],
                                    ),
                                  );
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

  void joinTurnuva(int? id) {
    _homeController.joinTurnuva("$id").then((value) {
      showToast("${value.description}",color: value.success?Colors.green:Colors.red);
    }).catchError((onError) {
      showToast("${onError.description}");
    });
  }
}
