import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/comment_bloc/comment_bloc.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/repositories/comment_repository.dart';
import 'package:thoughts/repositories/post_repository.dart';
import 'package:thoughts/shared_preferences_util.dart';
import 'package:thoughts/views/components/comment_component.dart';
import 'package:thoughts/views/components/comments_list.dart';
import 'package:thoughts/views/components/custom_widgets/custom_input_comment_row.dart';
import 'package:thoughts/views/components/feed_item.dart';
import 'package:thoughts/views/components/header.dart';

import '../constants.dart';
import 'components/footer.dart';

class PostScreen extends StatelessWidget {
  final Post post;
  final bool isFullPost;
  final commentsRepository = CommentRepository();
  late final String _uid;

  PostScreen({required this.post, required this.isFullPost, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferencesUtil.getData<String>(Constants.uid)
          .then((value) => _uid = value),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocProvider<CommentBloc>(
              create: (context) =>
                  CommentBloc(commentRepository: commentsRepository),
              child: Scaffold(
                appBar: Header(),
                body: Scrollbar(
                  thickness: 5.0,
                  radius: const Radius.circular(10.0),
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        children: [
                          isFullPost == true ? FeedItem(post: post) : Container(),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 110),
                              child: CommentsList(
                                  postId: post.idPost, userId: _uid)),
                        ],
                      ),
                      Positioned(
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: CustomInputCommentRow(postId: post.idPost),
                              ))),
                      Positioned(
                          child: Align(
                              alignment: Alignment.bottomCenter, child: Footer()))
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(
          child: Text('Произошла ошибка')
        );
      },
    );
  }
}
