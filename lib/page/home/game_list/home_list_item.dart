import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/hex_color.dart';
import 'package:repository_eyup/model/matches_model.dart';

class HomeListItem extends StatelessWidget {
  Match match;

  HomeListItem(this.match, {Key? key}) : super(key: key);
  late Color textColor;
  late Color tagColor;

  @override
  Widget build(BuildContext context) {
    if (match.gameType == 'voleybol') {
      textColor = Colors.deepPurple;
      tagColor = Colors.deepPurple.shade300;
    } else {
      textColor = Colors.black;
      tagColor = Colors.redAccent.shade200;
    }
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/gameDetail", arguments: match);
        },
        child: IntrinsicHeight(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${match.date!.split(":")[0]}:${match.date!.split(":")[1]} ${match.name}',
                    style: TextStyle(
                        color: textColor,
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
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "@${match.username} ${match.limit} kişilik maç istiyor...",
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            child: Text.rich(
                                TextSpan(
                                text: 'Maç ',
                                style: const TextStyle(fontSize: 11,color: Colors.grey),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text:match.ilce,
                                    style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(
                                    text:" oynanacak",
                                    style: TextStyle(fontSize: 11),
                                  )
                                ]
                            )),
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 5),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      width: 50,
                      child: Image.asset(match.gameType == 'voleybol'
                          ? "assets/images/voleyball.png"
                          : "assets/images/football.png"),
                    ),
                    SizedBox(
                      height: 30,
                      width: 65,
                      child: FlatButton(
                        color: (match.limit! ~/ 2) < match.joinedGamers!
                            ? (match.limit! != match.joinedGamers!
                                ? Colors.blue
                                : Colors.grey)
                            : HexColor.fromHex('#FFCE45'),
                        onPressed: () {},
                        child: Text(
                          '${match.joinedGamers}/${match.limit}',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.red.withAlpha(100),
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
                              margin: const EdgeInsets.only(right: 4, top: 4),
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: match.tagler![index] == "#ÜCRETSİZ"
                                      ? Colors.green
                                      : tagColor),
                              child: Text(
                                match.tagler![index],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
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
      ),
    );
  }
}
