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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Text(comment.infoUser.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(comment.content
                ),
              )]),
        ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 40,
              child: Text(comment.dateCreated,
              style: const TextStyle(
                color: Color.fromRGBO(102, 102, 102, 1),
                fontSize: 12
              ),),
            )
          ]
        ));
  }
}