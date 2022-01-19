import 'package:thoughts/entities/post.dart';

abstract class PostEvent {}

class PostLoadEvent extends PostEvent{}

class PostClearEvent extends PostEvent {}

class PostLikedEvent extends PostEvent {

  final Post post;
  bool fromProfile;

  PostLikedEvent ({required this.post, this.fromProfile = false});

}

class CreatePostButtonPressed extends PostEvent {
  String userId, content;

  CreatePostButtonPressed({required this.userId, required this.content});
}

class PostLoadForProfileEvent extends PostEvent {
  String userId;

  PostLoadForProfileEvent({required this.userId});
}