import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/widget/filter_drawer.dart';
import 'package:halisaha/widget/search_widget.dart';
import 'package:intl/intl.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/matches_model.dart';

import 'home_list_item.dart';

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  late DateTime _selectedDate;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController _homeController = HomeController();
  Map<String, String> map = {};
  final f = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
    map.putIfAbsent("tarih", () => f.format(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const Drawer(child: FilterDrawer()),
      body: LayoutBuilder(builder: (context, constraints) {
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
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openEndDrawer();
                          },
                          icon: const Icon(Icons.filter_alt_rounded)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.plus_one_rounded))
                    ],
                  ),
                ),
              ),
              CalendarTimeline(
                showYears: false,
                showMonth: false,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                dayWidth: 50,
                dayHeight: 60,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date!;
                    map["tarih"] = f.format(_selectedDate);
                  });
                },
                dayFontSize: 16,
                dayTextFontSize: 12,
                leftMargin: 20,
                monthColor: Colors.white70,
                dayColor: Colors.black,
                dayNameColor: const Color(0xFF333A47),
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Colors.green,
                dotsColor: const Color(0xFF333A47),
                locale: 'tr',
              ),
              Container(
                height: constraints.maxHeight - 135,
                color: Colors.black.withAlpha(20),
                child: FutureBuilder<List<Match>>(
                    future:_homeController.getLazyMatches(map),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: Text("Maç bulunamadı."));
                      }
                      EasyLoading.isShow ? EasyLoading.dismiss() : null;
                      var matches = snapshot.data;
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return HomeListItem(matches![index]);
                          });
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
