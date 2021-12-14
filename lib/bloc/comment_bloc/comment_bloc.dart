import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/comment_bloc/comment_event.dart';
import 'package:thoughts/bloc/comment_bloc/comment_state.dart';
import 'package:thoughts/entities/comment.dart';
import 'package:thoughts/repositories/comment_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository? commentRepository;

  CommentBloc({this.commentRepository})
      : assert(commentRepository != null),
        super(CommentEmptyState());

  CommentState get initialState => CommentEmptyState();

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is CommentLoadEvent) {
      yield CommentLoadingState();
      try {
        final List<Comment> _loadedCommentList =
            await commentRepository!.getAllComments(event.postId, event.userId);
        yield CommentLoadedState(loadedComment: _loadedCommentList);
      } catch (_) {
        yield CommentEmptyState();
      }
    }

    if (event is CreateCommentButtonPressed) {
      yield CommentLoadingState();
      try {
        final Comment _addedComment = await commentRepository!.createComment(event.userId, event.postId, event.content);
        final List<Comment> _lastLoadedCommentList = commentRepository!.getAllCommentsFromLastStorage();
        _lastLoadedCommentList.add(_addedComment);
        yield CommentLoadedState(loadedComment: _lastLoadedCommentList);
      } catch (_) {
        yield CommentErrorState();
      }
    }
  }
}