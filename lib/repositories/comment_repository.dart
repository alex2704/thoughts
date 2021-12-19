import 'package:thoughts/entities/comment.dart';
import 'package:thoughts/services/api/comment_api_provider.dart';

class CommentRepository {
  final CommentProvider _commentsProvider = CommentProvider();
  Future<List<Comment>> getAllComments(postId, userId) => _commentsProvider.getCommentsCollectionFromFirebase(postId, userId);
  List<Comment> getAllCommentsFromLastStorage() => _commentsProvider.getComments();
  Future<Comment> createComment(userId, postId, content) => _commentsProvider.createCommentInFirebase(userId, postId, content);
  Future deleteComment(String commentId) => _commentsProvider.deleteCommentInFirebase(commentId);
}