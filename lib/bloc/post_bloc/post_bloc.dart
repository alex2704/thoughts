import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_event.dart';
import 'package:thoughts/bloc/post_bloc/post_state.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/repositories/post_repository.dart';
import 'dart:developer' as developer;

class PostBloc extends Bloc<PostEvent, PostState>{

  final PostRepository? postRepository;

  PostBloc({this.postRepository})
      : assert(postRepository != null),
        super(PostEmptyState());

  PostState get initialState => PostEmptyState();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostLoadEvent) {
      yield PostLoadingState();
      try {
        final List<Post> _loadedPostList = await postRepository!.getAllPosts();
        yield PostLoadedState(loadedPost: _loadedPostList);
      } catch (_) {
        yield PostEmptyState();
      }
    }
    else if (event is PostClearEvent) {
      yield PostEmptyState();
    }
    else if(event is PostLikedEvent) {
      postRepository!.changeLikeStatus(event.post);
      List<Post> _postFromStorageList = postRepository!.getAllPostsFromStorage();
      yield PostLoadedState(loadedPost: _postFromStorageList);
    }
  }
}