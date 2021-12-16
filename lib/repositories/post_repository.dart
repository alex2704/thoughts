import 'package:dartz/dartz.dart';
import 'package:thoughts/core/error/failure.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/services/api/post_api_provider.dart';

class PostRepository {
  // Future<Either<Failure, List<PostEntity>>>getAllPosts();
  // Future<PostEntity> getPost();
  // Future<PostEntity> createPost(PostEntity postEntity);
  // void deletePost(int idPost);
  final PostProvider _postsProvider = PostProvider();
  Future<List<Post>> getAllPosts() => _postsProvider.getPostsCollectionFromFirebase();
  List<Post> getAllPostsFromStorage() => _postsProvider.getPosts();
  void changeLikeStatus (Post post) => _postsProvider.changeLikeStatus(post);
}