import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:thoughts/views/components/comment.dart';

class Post extends Equatable{
  final int idPost;
  final String? urlImg;
  final String? description;
  final int idUser;
  final int commentsCount;
  final int likesCount;
  final bool isLiked;
  final Timestamp dateCreated;
  // final List<Comment> comments;


  const Post({
      required this.idPost,
      required this.urlImg,
      required this.description,
      required this.idUser,
      required this.commentsCount,
      required this.likesCount,
      required this.isLiked,
      required this.dateCreated,
      // required this.comments
  });

  @override
  List<Object?> get props => [idPost, urlImg, description, idUser, commentsCount,
  likesCount, isLiked, dateCreated, ];
    // comments];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      idPost: json['id_post'],
      urlImg: json['url_img'],
      description: json['description'],
      idUser: json['id_user'],
      commentsCount: json['comments_count'],
      likesCount: json['likes_count'],
      isLiked: json['is_liked'],
      dateCreated: json['date_created'],
    );
  }
}