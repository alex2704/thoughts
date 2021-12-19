abstract class CommentEvent {}

class CommentLoadEvent extends CommentEvent {
  String userId, postId;

  CommentLoadEvent({required this.userId, required this.postId});

}

class CreateCommentButtonPressed extends CommentEvent {
  String userId, postId, content;

  CreateCommentButtonPressed({required this.userId, required this.postId, required this.content});
}

class DeleteCommentButtonPressed extends CommentEvent {
  String commentId;
  DeleteCommentButtonPressed({required this.commentId});
}

class CommentClearEvent extends CommentEvent {}
