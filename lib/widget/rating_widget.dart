// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/base_response.dart';

class Rating extends StatelessWidget {
  VenuesController controller;
  int? id;

  Rating({Key? key, required this.controller, required this.id})
      : super(key: key);
  int _initialRating = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RatingResponse>(
        future: controller.getVenueRates(id),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: Text("Puan yükleniyor..."));
          } else if (!snapshot.data!.success!) {
            _initialRating = 0;
          } else {
            _initialRating = snapshot.data!.field!;
          }
          return RatingBar.builder(
            initialRating: double.parse(_initialRating.toString()),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
              size: 12,
            ),
            onRatingUpdate: (rating) {
              controller.rateVenue(id, rating.ceil()).then((value) =>
                  showToast('${value.description}', color: Colors.redAccent));
            },
          );
        });
  }
}
