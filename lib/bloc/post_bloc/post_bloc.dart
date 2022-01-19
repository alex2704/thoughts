import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:thoughts/bloc/post_bloc/post_event.dart';
import 'package:thoughts/bloc/post_bloc/post_state.dart';
import 'package:thoughts/core/error/shared_preferences_exception.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/repositories/post_repository.dart';
import 'dart:developer' as developer;

import '../../constants.dart';
import '../../shared_preferences_util.dart';

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
        String _uid = await SharedPreferencesUtil.getData<String>(Constants.uid);
        final List<Post> _loadedPostList = await postRepository!.getAllPosts(_uid);
        yield PostLoadedState(loadedPost: _loadedPostList, loadedForProfile: []);
      } on SharedPreferencesException {
        final List<Post> _loadedPostList = await postRepository!.getAllPostsWithoutLogin();
        yield PostLoadedState(loadedPost: _loadedPostList, loadedForProfile: []);
      }
      catch (_) {
        yield PostEmptyState();
      }
    }
    else if (event is PostClearEvent) {
      yield PostEmptyState();
    }
    else if(event is PostLikedEvent) {
      String _uid = await SharedPreferencesUtil.getData<String>(Constants.uid);
      postRepository!.changeLikeStatus(event.post, _uid, event.fromProfile);
      List<Post> _postForProfileFromStorage = [];
      if (event.fromProfile) {
        _postForProfileFromStorage = postRepository!.getPostsForProfileFromStorage();
      }
      List<Post> _postFromStorageList = postRepository!.getAllPostsFromStorage();
      yield PostLoadedState(loadedPost: _postFromStorageList, loadedForProfile: _postForProfileFromStorage);
    }
    else if (event is CreatePostButtonPressed) {
      yield PostLoadingState();
      try {
        await postRepository!.createPost(event.userId, event.content);
        final List<Post> _lastLoadedPostList = await postRepository!.getAllPosts(event.userId);
        yield PostLoadedState(loadedPost: _lastLoadedPostList, loadedForProfile: []);
      } catch (_) {
        yield PostErrorState();
      }
    }
    else if(event is PostLoadForProfileEvent) {
      yield PostLoadingState();
      try {
        String _uid = await SharedPreferencesUtil.getData<String>(Constants.uid);
        final List<Post> _loadedPostList = postRepository!.getAllPostsFromStorage();
        final List<Post> _loadedPostsForProfile = await postRepository!.getPostsForProfile(event.userId, _uid);
        yield PostLoadedState(loadedPost: _loadedPostList, loadedForProfile: _loadedPostsForProfile);
      } on SharedPreferencesException {
        final List<Post> _loadedPostList = await postRepository!.getAllPostsWithoutLogin();
        yield PostLoadedState(loadedPost: _loadedPostList, loadedForProfile: []);
      }
      catch (_) {
        yield PostEmptyState();
      }
    }
  }
}