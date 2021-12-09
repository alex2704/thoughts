import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:thoughts/views/components/comment_component.dart';

import 'info_user.dart';

class Post extends Equatable {
  final String idPost;
  final String? urlImg;
  final String? description;
  final String idUser;
  final int commentsCount;
  final int likesCount;
  final bool isLiked;
  late final DateTime dateCreated;
  late final InfoUser infoUser;

  // final List<Comment> comments;

  Post(
      {required this.idPost,
      required this.urlImg,
      required this.description,
      required this.idUser,
      required this.commentsCount,
      required this.likesCount,
      required this.isLiked,
      required Timestamp dateCreated
      // required this.comments
      }) {
    this.dateCreated = dateCreated.toDate();
  }

  @override
  List<Object?> get props => [
        idPost,
        urlImg,
        description,
        idUser,
        commentsCount,
        likesCount,
        isLiked,
        dateCreated,
      ];

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
