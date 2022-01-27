import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/message_controller.dart';
import 'package:repository_eyup/model/message_detail.dart';
import 'package:hexcolor/hexcolor.dart';

class MessageDetails extends StatefulWidget {
  MessageDetails({Key? key}) : super(key: key);

  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  int i = 0;
  final MessageController _messageController = MessageController();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late Timer _timer;
  int _start = 10;
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
  void startTimer() {
    const oneSec = Duration(seconds: 15);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      body: BaseWidget(
        child: FutureBuilder<MessageDetail>(
            future: _messageController.getMessageDetail(id),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: Text("Mesajlar yükleniyor..."),
                );
              }
              snapshot.data!.messageDetailItem =
                  snapshot.data!.messageDetailItem!.reversed.toList();
              return ListView.separated(
                  itemCount: snapshot.data!.messageDetailItem!.length,
                  controller: _scrollController,
                  reverse: true,
                  itemBuilder: (context, index) {
                    MessageDetailItem item =
                        snapshot.data!.messageDetailItem![index];
                    return ListTile(
                      tileColor: Colors.redAccent,
                      trailing: item.userId == Constant.userId
                          ? getImageWidget(item.image)
                          : const SizedBox(),
                      leading: item.userId != Constant.userId
                          ? getImageWidget(item.image)
                          : const SizedBox(),
                      title: Text(
                        '${item.message}',
                        textAlign: item.userId == Constant.userId
                            ? TextAlign.right
                            : TextAlign.left,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.white,
                    );
                  });
            }),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        color: HexColor("#EDEDED"),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                maxLines: 1,
                textInputAction: TextInputAction.search,
                onChanged: (String val) {
                  // comment = val;
                },
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Yorum yaz...",
                  labelStyle: const TextStyle(fontSize: 11),
                  hintStyle: TextStyle(
                      fontSize: 12, color: Colors.grey.withAlpha(150)),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FloatingActionButton.small(
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  _messageController
                      .sendMessage(id, _controller.text)
                      .then((value) {
                    if (value) {
                      _controller.text = "";
                      setState(() {});
                    } else {
                      showToast("Hata Oluştu.");
                    }
                  });
                },
                child: const Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageWidget(String? url) {
    return Container(
      height: 35,
      width: 35,
      margin: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          "$url",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
