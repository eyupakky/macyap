import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
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
import 'home_list_item.dart';
import 'package:geocoding/geocoding.dart';

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> with LocationMixin {
  late DateTime _selectedDate, afterMonth;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController _homeController = HomeController();
  final AccountController _accountController = AccountController();
  Map<String, String> map = {};
  final f = DateFormat('dd.MM.yyyy');
  List<Match> matchList = [];
  String filter = "";
  bool sehir = false;
  final FirebaseController _firebaseController = FirebaseController();

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    EasyLoading.isShow ? "" : EasyLoading.show();
    getLocation().then((value) async {
      if (value != null) {
        placemarkFromCoordinates(value.latitude!, value.longitude!)
            .then((value) {
          setState(() {
            map.putIfAbsent("sehir", () => '${value[0].administrativeArea}');
            sehir = true;
          });
        });
        _firebaseController.sendLocation(value.latitude!, value.longitude!);
      } else {
        setState(() {
          sehir = true;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        sehir = true;
      });
    });
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
    afterMonth = DateTime.now();
    afterMonth.month + 1;
    map.putIfAbsent("tarih", () => f.format(_selectedDate));
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
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: SearchWidget(
                              hintText: "Maç ara...",
                              callback: (search) {
                                setState(() {
                                  map["search"] = search;
                                });
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState!.openEndDrawer();
                              },
                              icon: const Icon(Icons.filter_alt_rounded)),
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: const Icon(Icons.plus_one_rounded))
                        ],
                      ),
                    ),
                  ),
                  CalendarTimeline(
                    showYears: false,
                    showMonth: true,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    dayWidth: 50,
                    dayHeight: 60,
                    onDateSelected: (date) {
                      EasyLoading.show();
                      setState(() {
                        _selectedDate = date!;
                        map["tarih"] = f.format(_selectedDate);
                      });
                    },
                    dayFontSize: 14,
                    dayTextFontSize: 12,
                    leftMargin: 20,
                    monthColor: Colors.black,
                    dayColor: Colors.black,
                    dayNameColor: const Color(0xFF333A47),
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: Colors.redAccent,
                    dotsColor: const Color(0xFF333A47),
                    locale: 'tr',
                  ),
                  Container(
                    height: constraints.maxHeight - 165,
                    color: Colors.black.withAlpha(20),
                    child: BlocBuilder<GameFavorite, bool>(
                        builder: (context, count) {
                      return !sehir
                          ? Container(
                              color: Colors.white,
                              child: const Text(
                                  "Lütfen konum izni verin ve konumuzunu açın..."))
                          : FutureBuilder<List<Match>>(
                              future: _homeController.getLazyMatches(map),
                              builder: (context, snapshot) {
                                if (snapshot.error == "Sonuc boş.") {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: const Center(
                                      child: Text("Bir hata oluştu."),
                                    ),
                                  );
                                } else if (snapshot.data == null ||
                                    snapshot.data!.isEmpty) {
                                  EasyLoading.isShow
                                      ? EasyLoading.dismiss()
                                      : null;
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
              return Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(bottom: 50),
                child: FloatingActionButton.small(
                  onPressed: () {
                    Navigator.pushNamed(context, "/createGame");
                  },
                  child: const Icon(Icons.add),
                ),
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
