// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/comment_list.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/comment.dart';

class VenuesReviews extends StatelessWidget {
  VoidCallback callback;
  int? id;

  VenuesReviews({Key? key, required this.callback, required this.id})
      : super(key: key);
  final VenuesController _venuesController = VenuesController();
  late String comment;
  TextEditingController controller = TextEditingController();
  int commentSize = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NewVenuesComment, int>(builder: (context, count) {
          return FutureBuilder<Comment>(
              future: _venuesController.getVenueComments(id),
              builder: (context, snapshot) {
                if (snapshot.data != null &&
                    snapshot.data!.comments!.isNotEmpty) {
                  return CommentList(comment: snapshot.data);
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text("Yorumlar yükleniyor..."),
                  );
                } else {
                  return const Center(
                    child: Text("Yorum yok..."),
                  );
                }
              });
        }),
      ),
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
                  _venuesController.addVenueComment(id, comment).then((value) {
                    if (value.success!) {
                      controller.text = "";
                      context
                          .read<NewVenuesComment>()
                          .changeVenuesComment(commentSize++);
                    } else {
                      showToast(value.description!);
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
}
