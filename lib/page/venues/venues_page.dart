import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/widget/search_widget.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/urunler_model.dart';
import 'package:repository_eyup/model/venues_model.dart';

class PlacesPage extends StatefulWidget {
  PlacesPage({Key? key}) : super(key: key);

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  final VenuesController _venuesController = VenuesController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String search = "";

  @override
  Widget build(BuildContext context) {
    EasyLoading.show();
    return Scaffold(
      key: _scaffoldKey,
      body: BaseWidget(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: SearchWidget(
                          hintText: "Mekan ara...",
                          callback: (search) {
                            setState(() {
                              this.search = search;
                            });
                          },
                        ),
                      ),
                      // TODO filtre eklenecek
                      // IconButton(
                      //     onPressed: () {
                      //       _scaffoldKey.currentState!.openEndDrawer();
                      //     },
                      //     icon: const Icon(Icons.filter_alt_rounded)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight - 60,
                child: FutureBuilder<UrunlerModel>(
                    future: _venuesController.getShoppingList(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: Text("Mekan bulunamadı."));
                      }
                      EasyLoading.dismiss();
                      var matches = snapshot.data;
                      return ListView.separated(
                        itemCount: matches!.value!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Value value = matches.value![index];
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/venuesDetail",
                                  arguments: value.id);
                            },
                            title: Text(
                              '${value.baslik}',
                              style: const TextStyle(fontSize: 12,color: Colors.black),
                            ),
                            leading: Container(
                              width: 60,
                              margin: const EdgeInsets.all(12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://macyap.com.tr/Content/UrunImg/${value.img}',
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            subtitle: Text(
                              '${value.fiyat} TL',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 1,
                            color: Colors.red.withAlpha(100),
                          );
                        },
                      );
                    }),
              )
            ],
          );
        }),
      ),
    );
  }
}
