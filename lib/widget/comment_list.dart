import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/model/comment.dart';

class CommentList extends StatelessWidget {
  Comment? comment;
  CommentList({Key? key,required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black38,thickness: 1,
      ),
      itemCount: comment!.comments!.length,
      itemBuilder: (context, index) => ListTile(
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
        title: Text('@${comment!.comments![index].username}',style: const TextStyle(fontSize: 12),),
        subtitle:
        Text('${comment!.comments![index].comment}',style: const TextStyle(fontSize: 10)),
      ),
    );
  }
}
