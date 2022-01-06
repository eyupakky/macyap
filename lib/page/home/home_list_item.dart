import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/matches_model.dart';

class HomeListItem extends StatelessWidget {
  Match match;

  HomeListItem(this.match, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 140,
        padding: const EdgeInsets.only(left: 18, top: 18, right: 12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${match.date} ${match.name}',
                style: const TextStyle(
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
                      "https://macyap.com.tr/Content/game_user/${match.image}",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    "${match.limit!~/2} ye ${match.limit!~/2} @${match.username}",
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      '10/${match.limit}',
                      style: const TextStyle(fontSize: 10),
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
                  flex: 16,
                  child: Wrap(
                    children: List<Widget>.generate(
                      match.tagler != null ? match.tagler!.length : 0,
                      (int index) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.grey.shade200),
                          child: Text(
                            match.tagler![index],
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
                Expanded(
                    flex: 3,
                    child: Text(
                      "${match.gamePrice} TRY",
                      style: const TextStyle(
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
