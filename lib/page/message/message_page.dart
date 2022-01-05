import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/controller/message_controller.dart';
import 'package:repository_eyup/model/matches_model.dart';
import 'package:repository_eyup/model/message_model.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);
  final MessageController _messageController = MessageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Container(
                margin: const EdgeInsets.all(12),
                child: const Text(
                  "Mesajlar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: constraints.maxHeight - 50,
              child: FutureBuilder<List<MessageModel>>(
                  future: _messageController.getLazyMessage(),
                  builder: (context, snapshot) {
                    // if (snapshot.data == null) {
                    //   return const Center(child: Text("Mekan bulunamadı."));
                    // }
                    var matches = snapshot.data;
                    return ListView.builder(
                        itemCount: 18,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/messageDetails");
                                },
                                title: const Text(
                                  "@eyüpakkaya",
                                  style: TextStyle(fontSize: 13),
                                ),
                                leading: Container(
                                  height: 35,
                                  width: 35,
                                  margin: const EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      "https://www.itemhesap.com/uploads/blocks/block_6155609a164302-38911972-90307848.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 50,
                                  child: Text(
                                    "16 Ara",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400),
                                  ),
                                ),
                                subtitle: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  // TextOverflow.clip // TextOverflow.fade
                                  text: TextSpan(
                                    text:
                                        "Selam takıma benide alabilir misiniz ? Normal bir takım oyuncusuyum.",
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 12),
                                  ),
                                )),
                          );
                        });
                  }),
            ),
          ],
        );
      }),
    );
  }
}
