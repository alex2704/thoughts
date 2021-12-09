import 'package:thoughts/entities/comment.dart';
import 'package:thoughts/services/api/comment_api_provider.dart';

class CommentRepository {
  final CommentProvider _commentsProvider = CommentProvider();
  Future<List<Comment>> getAllComments(postId, userId) => _commentsProvider.getCommentsCollectionFromFirebase(postId, userId);
}