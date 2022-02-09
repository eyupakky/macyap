import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/home/game_list/game_detail/line_up.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/game_detail.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'game_detail/comment.dart';
import 'game_detail/info_tab.dart';

class GameDetailPage extends StatefulWidget {
  GameDetailPage({Key? key}) : super(key: key);

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final HomeController _homeController = HomeController();
  late Match match;
  late int id = 0;
  late GameDetail _detail;

  @override
  void initState() {
    super.initState();
    _detail= GameDetail();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments is Match) {
      match = ModalRoute.of(context)!.settings.arguments as Match;
    } else {
      id = ModalRoute.of(context)!.settings.arguments as int;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.red,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontSize: 16),
          unselectedLabelStyle: const TextStyle(fontSize: 13),
          tabs: const [
            Tab(
              text: "Bilgi",
            ),
            Tab(text: "Takım"),
            Tab(text: "Yorumlar"),
          ],
        ),
        title: Text(
          id != 0 ? 'Maç detayı' : '${match.name}',
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      body: BaseWidget(
        child: TabBarView(
          controller: _tabController,
          children: [
            GameDetailInfoTab(
                id: id != 0 ? id : match.gameId,
                homeController: _homeController,
                callback: (GameDetail detail) {
                  AppConfig.gameDetail = detail;
                    _tabController.animateTo(1);
                }),
            LineUp(
              homeController: _homeController,
              id: id != 0 ? id : match.gameId ?? 0,
            ),
            CommentTab(
              homeController: _homeController,
              id: id != 0 ? id : match.gameId ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}
