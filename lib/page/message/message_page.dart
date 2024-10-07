import 'package:flutter/material.dart';
import 'package:halisaha/base_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:repository_eyup/controller/message_controller.dart';
import 'package:repository_eyup/model/message_model.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);
  final MessageController _messageController = MessageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget(
        child: LayoutBuilder(builder: (context, constraints) {
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
                child: FutureBuilder<MessageModel>(
                    future: _messageController.getLazyMessage(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                            child: Text("Mesajlar yükleniyor..."));
                      } else if (snapshot.data!.messageItem!.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset('assets/images/message.json',
                                  width: 100, height: 100),
                              const Text("Mesajınız yok"),
                            ],
                          ),
                        );
                      }
                      var message = snapshot.data;
                      return ListView.builder(
                          itemCount: message!.messageItem!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            MessageItem item = message.messageItem![index];
                            return Card(
                              child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/messageDetails",
                                        arguments: item.userId);
                                  },
                                  title: Text(
                                    "@${item.username}",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  leading: Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(right: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "${item.image}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  subtitle: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    // TextOverflow.clip // TextOverflow.fade
                                    text: TextSpan(
                                      text: item.message ?? '',
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
      ),
    );
  }
}
