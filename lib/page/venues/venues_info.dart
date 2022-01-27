import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:halisaha/widget/rating_widget.dart';
import 'package:repository_eyup/controller/venues_controller.dart';

import 'package:repository_eyup/model/venues_detail_model.dart';
import 'package:url_launcher/url_launcher.dart';

class VenuesInfoTab extends StatelessWidget {
  VoidCallback callback;
  VenusDetailModel? venues;
  VenuesController controller;

  VenuesInfoTab(
      {Key? key, this.venues, required this.callback, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Rating(
              controller: controller,
              id: venues!.id,
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: List<Widget>.generate(
                venues!.tags != null ? venues!.tags!.length : 0,
                (int index) {
                  return Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.redAccent.shade200),
                    child: Text(
                      venues!.tags![index],
                      style: const TextStyle(
                        fontSize: 10,color: Colors.white,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            ListTile(
              title: Text(
                'Adres: ${venues!.address}',
                style: const TextStyle(
                    fontSize: 12, fontFamily: "Montserrat-normal"),
              ),
            ),
            ListTile(
              title: Text(
                '${venues!.description}',
                style: const TextStyle(
                    fontSize: 12, fontFamily: "Montserrat-normal"),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: List<Widget>.generate(
                  venues!.tel != null ? venues!.tel!.length : 0,
                  (int index) {
                    return Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.grey.shade200),
                      child: Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'Tel: ',
                            style: TextStyle(
                                fontSize: 12, fontFamily: "Montserrat-normal")),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => launch("tel:${venues!.tel![index]}"),
                            text: venues!.tel![index],
                            style: const TextStyle(
                              fontSize: 12,
                            ))
                      ])),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
