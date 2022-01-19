import 'package:dartz/dartz.dart';
import 'package:thoughts/core/error/failure.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/services/api/post_api_provider.dart';

class PostRepository {
  final PostProvider _postsProvider = PostProvider();
  Future<List<Post>> getAllPosts(String userId) => _postsProvider.getPostsCollectionFromFirebase(userId);
  List<Post> getAllPostsFromStorage() => _postsProvider.getPosts();
  List<Post> getPostsForProfileFromStorage() => _postsProvider.getPostsForProfile();
  void changeLikeStatus (Post post, String userId, bool fromProfile) => _postsProvider.changeLikeStatus(post, userId, fromProfile);
  Future<List<Post>> getAllPostsWithoutLogin() => _postsProvider.getPostsCollectionWithoutLoginFromFirebase();
  Future<Post> createPost(userId, content) => _postsProvider.createPostInFirebase(userId, content);
  Future<List<Post>> getPostsForProfile(userId, uid) => _postsProvider.getPostsForProfileFromFirebase(userId, uid);
}