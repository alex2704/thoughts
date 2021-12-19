import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thoughts/bloc/comment_bloc/comment_bloc.dart';
import 'package:thoughts/bloc/comment_bloc/comment_event.dart';
import 'package:thoughts/entities/comment.dart';

class CommentComponent extends StatelessWidget {

  final Comment comment;

  const CommentComponent({required this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommentBloc commentBloc = BlocProvider.of<CommentBloc>(context);
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
              child: Column(
                children: [Text(comment.dateCreated,
                style: const TextStyle(
                  color: Color.fromRGBO(102, 102, 102, 1),
                  fontSize: 12
                ),),

                comment.isOwn ?
                IconButton(onPressed: () => {
                  commentBloc.add(DeleteCommentButtonPressed(commentId: comment.idComment)),
                  _notify("Комментарий успешно удален")
                },
                    icon: const Icon(Icons.delete_outline, size: 25,) ) : Container()],
              ),
            )
          ]
        ));
  }

  void _notify(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.orange,
        fontSize: 16.0);
  }
}