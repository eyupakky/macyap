import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/widget/search_widget.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
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
      body: LayoutBuilder(builder: (context, constraints) {
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
                    IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        icon: const Icon(Icons.filter_alt_rounded)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight - 60,
              child: FutureBuilder<VenusModel>(
                  future: _venuesController.getLazyVenues(search),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: Text("Mekan bulunamadı."));
                    }
                    EasyLoading.dismiss();
                    var matches = snapshot.data;
                    return ListView.separated(
                      itemCount: matches!.venues!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Venues venues = matches.venues![index];
                        return ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, "/venuesDetail",
                                arguments: venues);
                          },
                          title: Text(
                            '${venues.name}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          leading: Container(
                            width: 60,
                            margin: const EdgeInsets.all(12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: '${venues.image}',
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
                          // trailing: SizedBox(
                          //   width: 50,
                          //   child: Wrap(
                          //     alignment: WrapAlignment.center,
                          //     children: [
                          //       const RotationTransition(
                          //           turns: AlwaysStoppedAnimation(45 / 360),
                          //           child: Icon(
                          //             Icons.navigation,
                          //             size: 24,
                          //           )),
                          //       Text(
                          //         "4.6 km",
                          //         style: TextStyle(
                          //             fontSize: 12,
                          //             color: Colors.grey.shade400),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          subtitle: Text(
                            '${venues.address}',
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 9),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          thickness: 1,
                          color: Colors.grey.withAlpha(50),
                        );
                      },
                    );
                  }),
            )
          ],
        );
      }),
    );
  }
}
