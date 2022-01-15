import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:repository_eyup/model/matches_model.dart';

class HomeListItem extends StatelessWidget {
  Match match;

  HomeListItem(this.match, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/gameDetail", arguments: match);
        },
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
                      fontSize: 12),
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
                        "${match.image}",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "${match.limit! ~/ 2} ye ${match.limit! ~/ 2} @${match.username}",
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 65,
                    child: FlatButton(
                      color: (match.limit! ~/ 2) < match.joinedGamers!
                          ? ((match.limit! ~/ 2) == match.joinedGamers!
                              ? Colors.blue
                              : Colors.grey)
                          : HexColor('#FFCE45'),
                      onPressed: () {},
                      child: Text(
                        '${match.joinedGamers}/${match.limit}',
                        style: const TextStyle(fontSize: 10,color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 14,
                    child: Wrap(
                      children: List<Widget>.generate(
                        match.tagler != null ? match.tagler!.length : 0,
                        (int index) {
                          return Container(
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
      ),
    );
  }
}
