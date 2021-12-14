import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/comment_bloc/comment_bloc.dart';
import 'package:thoughts/bloc/comment_bloc/comment_event.dart';
import 'package:thoughts/bloc/comment_bloc/comment_state.dart';
import 'package:thoughts/views/components/comment_component.dart';

class CommentsList extends StatelessWidget {
  final String userId;
  final String postId;

  const CommentsList({required this.userId, required this.postId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommentBloc commentBloc = BlocProvider.of<CommentBloc>(context);
    commentBloc.add(CommentLoadEvent(userId: userId, postId: postId));
    return BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
      if (state is CommentEmptyState) {
        return const Center(
          child: Text('Ошибка. Не удалось загрузить комментарии'),
        );
      }

      if (state is CommentLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is CommentLoadedState) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.loadedComment.length,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return CommentComponent(comment: state.loadedComment[index]);
            });
      }
      return const Center(child: Text('Произошла ошибка'));
    });
  }
}
