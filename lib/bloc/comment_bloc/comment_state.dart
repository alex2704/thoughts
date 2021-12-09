abstract class CommentState {}

class CommentEmptyState extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {
  List<dynamic> loadedComment;

  CommentLoadedState({required this.loadedComment});
}

class CommentErrorState extends CommentState {}
