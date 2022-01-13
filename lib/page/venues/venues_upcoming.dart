import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/page/home/game_list/home_list_item.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/base_response.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/venues_model.dart';

class VenuesUpcoming extends StatelessWidget {
  VoidCallback callback;
  int? id;

  VenuesUpcoming({Key? key, required this.callback, required this.id})
      : super(key: key);
  final VenuesController _venuesController = VenuesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<MatchesModel>(
      future: _venuesController.getUpComingGames(id),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: Text("Maç aranıyor..."));
        } else if (snapshot.data!.match!.isEmpty) {
          return const Center(child: Text("Maç bulunamadı..."));
        }
        var matches = snapshot.data;
        return ListView.builder(
            itemCount: matches!.match!.length,
            itemBuilder: (context, index) {
              EasyLoading.isShow ? EasyLoading.dismiss() : null;
              return HomeListItem(matches.match![index]);
            });
      },
    ));
  }
}
