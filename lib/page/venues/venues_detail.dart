import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/page/venues/venues_info.dart';
import 'package:halisaha/page/venues/venues_reviews.dart';
import 'package:halisaha/page/venues/venues_upcoming.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/urun_details.dart';
import 'package:repository_eyup/model/venues_detail_model.dart';
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

    return FutureBuilder<UrunlerDetailModel>(
        future: _venuesController.getShoppingDetail(id),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: Text("Sonuç bekleniyor..."));
          }
          EasyLoading.dismiss();
          UrunlerDetailModel? detailModel = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                '${detailModel?.detail!.baslik}',
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            body: Column(
              children: [
                CachedNetworkImage(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: "${detailModel?.detail!.img}",
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          );
        });
  }
}
