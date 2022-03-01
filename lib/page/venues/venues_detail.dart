import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/venues/venues_info.dart';
import 'package:halisaha/page/venues/venues_reviews.dart';
import 'package:halisaha/page/venues/venues_upcoming.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/venues_detail_model.dart';
import 'package:repository_eyup/model/venues_model.dart';
import 'package:url_launcher/url_launcher.dart';

class VenuesDetail extends StatefulWidget {
  VenuesDetail({Key? key}) : super(key: key);

  @override
  State<VenuesDetail> createState() => _VenuesDetailState();
}

class _VenuesDetailState extends State<VenuesDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final VenuesController _venuesController = VenuesController();
  String url = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    return FutureBuilder<VenusDetailModel>(
        future: _venuesController.getVenuesDetail(id),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: Text("Sonuç bekleniyor..."));
          }
          EasyLoading.dismiss();
          VenusDetailModel? venueDetail = snapshot.data;
          context
              .read<ChangeFavorite>()
              .changeFavorite(venueDetail!.follow ?? false);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                '${venueDetail.name}',
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            body: Column(
              children: [
                CachedNetworkImage(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: "${venueDetail.image}",
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListTile(
                        leading:SizedBox(
                          height: 100,
                          width: 40,
                          child: Transform.rotate(
                            angle:  0.75,
                            child:  IconButton(
                              icon: Icon(
                                Icons.navigation_sharp,
                                color: Theme.of(context).primaryColor.withAlpha(150),
                              ),
                              onPressed: null,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (Platform.isAndroid) {
                            url =
                                "https://www.google.com/maps/search/?api=1&query=${venueDetail.locationX},${venueDetail.locationY}";
                          } else {
                            url =
                                'https://maps.apple.com/?q=${venueDetail.locationX},${venueDetail.locationY}';
                          }
                          launch(url);
                        },
                        tileColor: Colors.grey.withAlpha(10),
                        title: Text(
                          '${venueDetail.followers} Takipçi',
                          style: const TextStyle(fontSize: 12),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                              text: '${venueDetail.address} *',
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                              children: const [
                                TextSpan(
                                    text: "Sahaya Git",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black))
                              ]),
                        ),
                      ),
                    ),
                    Expanded(child: BlocBuilder<ChangeFavorite, bool>(
                        builder: (context, count) {
                      return GestureDetector(
                        onTap: () {
                          if (!venueDetail.follow!) {
                            EasyLoading.show();
                            _venuesController
                                .venuesFavorite(venueDetail.id)
                                .then((value) {
                              EasyLoading.dismiss();
                              venueDetail.follow = value.success;
                              context
                                  .read<ChangeFavorite>()
                                  .changeFavorite(value.success ?? false);
                            });
                          }
                        },
                        child: Container(
                          color: Colors.grey.withAlpha(10),
                          child: !venueDetail.follow!
                              ? Icon(
                                  Icons.favorite_border,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).primaryColor,
                                ),
                        ),
                      );
                    }))
                  ],
                ),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.black,
                  unselectedLabelStyle: const TextStyle(
                      fontFamily: "Montserrat-normal", fontSize: 12),
                  labelStyle: const TextStyle(
                      fontFamily: "Montserrat-bold", fontSize: 12),
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Bilgi"),
                    Tab(text: "Yaklaşanlar"),
                    Tab(text: "Yorumlar"),
                  ],
                ),
                // tab bar view here
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      VenuesInfoTab(
                          venues: venueDetail,
                          controller: _venuesController,
                          callback: () {
                            _tabController.animateTo(1);
                          }),
                      VenuesUpcoming(
                          id: venueDetail.id,
                          callback: () {
                            _tabController.animateTo(1);
                          }),
                      VenuesReviews(
                        callback: () {
                          _tabController.animateTo(1);
                        },
                        id: venueDetail.id,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
