import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/page/home/game_list/game_detail/line_up.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'game_detail/comment.dart';
import 'game_detail/info_tab.dart';

class GameDetail extends StatefulWidget {
  GameDetail({Key? key}) : super(key: key);

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Match match = ModalRoute.of(context)!.settings.arguments as Match;

    return MaterialApp(
      home: Scaffold(
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
            tabs: const [
              Tab(
                text: "Bilgi",
              ),
              Tab(text: "Takım"),
              Tab(text: "Yorumlar"),
            ],
          ),
          title: Text(
            '${match.name}',
            style: const TextStyle(color: Colors.black,fontSize: 14),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GameDetailInfoTab(
                id: match.gameId,
                homeController: _homeController,
                callback: () {
                  _tabController.animateTo(1);
                }),
            LineUp(
              homeController: _homeController,
              id: match.gameId ?? 0,
            ),
            CommentTab(
              homeController: _homeController,
              id: match.gameId ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}
