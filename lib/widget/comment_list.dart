// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:repository_eyup/model/comment.dart';

class CommentList extends StatelessWidget {
  Comment? comment;
  CommentList({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.red.shade100,
        thickness: 1,
      ),
      itemCount: comment!.comments!.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/profile',
              arguments: comment!.comments![index].userId);
        },
        leading: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(right: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              '${comment!.comments![index].image}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          '@${comment!.comments![index].username}',
          style: const TextStyle(fontSize: 12, color: Colors.red),
        ),
        subtitle: Text('${comment!.comments![index].comment}',
            style: const TextStyle(fontSize: 10)),
      ),
    );
  }
}
