import 'package:thoughts/entities/post.dart';

abstract class PostEvent {}

class PostLoadEvent extends PostEvent{}

class PostClearEvent extends PostEvent {}

class PostLikedEvent extends PostEvent {

  final Post post;

  PostLikedEvent ({required this.post});

}