import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/comment_list.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/comment.dart';

class CommentTab extends StatefulWidget {
  HomeController homeController;
  int? id;

  CommentTab({Key? key, required this.homeController, required this.id})
      : super(key: key);

  @override
  State<CommentTab> createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  late String comment;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.all(8),
        color: Colors.grey.withAlpha(50),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                maxLines: 1,
                textInputAction: TextInputAction.search,
                onChanged: (String val) {
                  comment = val;
                },
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Yorum yaz...",
                  labelStyle: const TextStyle(fontSize: 11),
                  hintStyle: TextStyle(
                      fontSize: 12, color: Colors.grey.withAlpha(150)),
                  // prefixIcon: const Icon(Icons.search),
                  // border: const OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(
                  //         Radius.circular(25.0)))
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FloatingActionButton.small(
                onPressed: () {
                  widget.homeController
                      .sendComment(comment, widget.id)
                      .then((value) {
                    if (value.success!) {
                      controller.text = "";
                      setState(() {});
                    } else {
                      showToast(value.description!);
                    }
                  });
                },
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<Comment>(
            future: widget.homeController.getGameComment(widget.id!),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return CommentList(comment: snapshot.data);
              } else {
                return const Center(
                  child: Text("Yorum yok..."),
                );
              }
            }),
      ),
    );
  }
}
