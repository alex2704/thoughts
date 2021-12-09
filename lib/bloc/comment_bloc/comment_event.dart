abstract class CommentEvent {}

class CommentLoadEvent extends CommentEvent {
  String userId, postId;

  CommentLoadEvent({required this.userId, required this.postId});
}

class CommentClearEvent extends CommentEvent {}
