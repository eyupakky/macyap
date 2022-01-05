import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/widget/search_widget.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/venues_model.dart';

import 'home/home_list_item.dart';

class PlacesPage extends StatelessWidget {
  PlacesPage({Key? key}) : super(key: key);
  final VenuesController _venuesController = VenuesController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                      child: SearchWidget(hintText: "Mekan ara..."),
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
              child: FutureBuilder<List<VenusModel>>(
                  future: _venuesController.getLazyVenues(),
                  builder: (context, snapshot) {
                    // if (snapshot.data == null) {
                    //   return const Center(child: Text("Mekan bulunamadı."));
                    // }
                    var matches = snapshot.data;
                    return ListView.builder(
                        itemCount: 18,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: const Text("Woodlouse College"),
                            trailing: SizedBox(
                                width: 50,
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children:  [
                                const RotationTransition(
                                turns: AlwaysStoppedAnimation(45 / 360),
                                child: Icon(Icons.navigation,size: 24,)),
                            Text("4.6 km",style: TextStyle(fontSize: 12,color: Colors.grey.shade400),)
                            ],
                          ),
                          ),
                          subtitle: Text(
                          "London N12 9EY,  UK",
                          style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 12),
                          ),
                          );
                        });
                  }),
            )
          ],
        );
      }),
    );
  }
}
