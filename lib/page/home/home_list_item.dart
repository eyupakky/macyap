import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/matches_model.dart';

class HomeListItem extends StatelessWidget {
  HomeListItem({Key? key}) : super(key: key);
  late int? _value = 1;

  @override
  Widget build(BuildContext context) {
          return Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              padding: const EdgeInsets.only(left: 18, top: 18, right: 12),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "3:00 PM - Westway Sport Centre",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "https://www.itemhesap.com/uploads/blocks/block_6155609a164302-38911972-90307848.png",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 6,
                        child: Text(
                          "3:00 PM - Westway Sport Centre",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            '10/14',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 14,
                        child: Wrap(
                          children: List<Widget>.generate(
                            3,
                            (int index) {
                              return Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: Colors.grey.shade200),
                                child: Text(
                                  'item$index',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      const Expanded(
                          flex: 2,
                          child: Text(
                            "24 TRY",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ))
                    ],
                  )
                ],
              ),
            ),
          );

  }
}
