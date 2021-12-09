import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/entities/comment.dart';

class CommentComponent extends StatelessWidget {

  final Comment comment;

  const CommentComponent({required this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
        children: [
            const Text('another_user',
              style: TextStyle(
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(comment.content
            )]),
            Text('вчера',
            style: const TextStyle(
              color: Color.fromRGBO(102, 102, 102, 1),
              fontSize: 12
            ),)
          ]
        ));
  }
}