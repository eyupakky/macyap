import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/game_detail.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../help/utils.dart';
typedef FunctionGameDetail = Function(GameDetail gameDetail);
class GameDetailInfoTab extends StatelessWidget {
  int? id;
  FunctionGameDetail callback;
  HomeController homeController;

  GameDetailInfoTab(
      {Key? key, this.id, required this.homeController, required this.callback})
      : super(key: key);
  late GameDetail gameDetail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FlatButton(
          minWidth: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(8),
          onPressed: () {
            callback(gameDetail);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
          child: Text(
            "Maç Kadrosunu Gör",
            style: GoogleFonts.montserrat(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          color: Colors.red.withOpacity(0.9)),
      body: FutureBuilder<GameDetail>(
          future: homeController.getGameDetail(id!),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              gameDetail = snapshot.data!;
              AppConfig.gameDetail = gameDetail;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: "${gameDetail.imageVenue}",
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.black54,
                        size: 20,
                      ),
                      title: Text(
                        '${gameDetail.gunSayi} ${gameDetail.ay} ${gameDetail.gun}, ${gameDetail.yil}',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.access_time_outlined,
                        color: Colors.black54,
                        size: 20,
                      ),
                      title: Text(
                        '${gameDetail.gameStart}',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        launch(
                            'https://www.google.com/maps/search/?api=1&query=${gameDetail.locationX},${gameDetail.locationY}');
                      },
                      leading: const Icon(Icons.location_on,
                          color: Colors.black54, size: 20),
                      subtitle: Text(
                        '${gameDetail.gameVenueAddres}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      title: Text(
                        '${gameDetail.gameVenueName}',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.credit_card,
                          color: Colors.black54, size: 20),
                      subtitle: const Text('Çevrimiçi ödeme',
                          style: TextStyle(fontSize: 12)),
                      title: Text(
                        '${gameDetail.gamePrice} / Kişi başı',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile',
                            arguments: gameDetail.userId);
                      },
                      title: Text("${gameDetail.gameOrg}"),
                      // subtitle:Text("@${gameDetail.gameOrg}"),
                      leading: Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            '${gameDetail.orgImage}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      subtitle:  Column(
                        crossAxisAlignment:CrossAxisAlignment.start ,
                        children:  [
                          const Text(
                            'Organizatör',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 5,),
                          InkWell(onTap: (){
                            launch('tel:${gameDetail.orgTel}');
                          },child: Text('${gameDetail.orgTel}',style: const TextStyle(color: Colors.black,fontSize: 12),))
                        ],
                      ),
                    ),
                    Wrap(
                      children: List<Widget>.generate(
                        gameDetail.tags != null ? gameDetail.tags!.length : 0,
                        (int index) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.red.shade200),
                            child: Text(
                              gameDetail.tags![index],
                              style: const TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Bilgi',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('${gameDetail.gameDesc}',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 13)),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
