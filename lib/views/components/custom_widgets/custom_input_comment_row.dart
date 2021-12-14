import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/comment_bloc/comment_bloc.dart';
import 'package:thoughts/bloc/comment_bloc/comment_event.dart';
import 'package:thoughts/constants.dart';
import 'package:thoughts/shared_preferences_util.dart';
import 'package:thoughts/theme/colors.dart';

class CustomInputCommentRow extends StatefulWidget {
  final String postId;

  const CustomInputCommentRow({required this.postId, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InputCommentRowState(postId: postId);
  }
}

class _InputCommentRowState extends State<CustomInputCommentRow> {
  final controller = TextEditingController();
  final String postId;
  late final String uid;

  _InputCommentRowState({required this.postId});


  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.getData<String>(Constants.uid).then((value) => uid = value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CommentBloc commentBloc = BlocProvider.of<CommentBloc>(context);
    String commentText;
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            width: MediaQuery.of(context).size.width - 62,
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              controller: controller,
              autofocus: false,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 100),
                  filled: true,
                  fillColor: CustomColors.orange,
                  hintText: 'Ваш комментарий...',
                  hintStyle: const TextStyle(color: Colors.white),
                  contentPadding:
                      const EdgeInsets.only(left: 20.0, bottom: 5, top: 8),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: CustomColors.orange),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: CustomColors.orange),
                    borderRadius: BorderRadius.circular(25.7),
                  )),
            ),
          ),
          Container(
            color: Colors.white,
            child: FloatingActionButton(
                onPressed: () {
                  commentText = controller.text;
                  if (commentText.isEmpty) return;
                  print(commentText);
                  FocusScope.of(context).unfocus();
                  controller.clear();
                  commentBloc.add(CreateCommentButtonPressed(userId: uid, content: commentText, postId: postId));
                },
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                hoverElevation: 0,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.send,
                  size: 25,
                  color: Colors.black,
                )),
          )
        ],
      ),
    );
  }
}
