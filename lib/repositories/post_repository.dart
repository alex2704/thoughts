import 'package:dartz/dartz.dart';
import 'package:thoughts/core/error/failure.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/services/api/post_api_provider.dart';

class PostRepository {
  final PostProvider _postsProvider = PostProvider();
  Future<List<Post>> getAllPosts(String userId) => _postsProvider.getPostsCollectionFromFirebase(userId);
  List<Post> getAllPostsFromStorage() => _postsProvider.getPosts();
  void changeLikeStatus (Post post, String userId) => _postsProvider.changeLikeStatus(post, userId);
}