import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:thoughts/views/components/comment_component.dart';

import 'info_user.dart';

class Post extends Equatable {
  final String idPost;
  String urlImg;
  final String description;
  final String idUser;
  final int commentsCount;
  final int likesCount;
  late bool isLiked;
  late final String dateCreated;
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
    this.dateCreated = _toDisplayedDate(dateCreated);
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

  _toDisplayedDate(Timestamp timestamp) {
    DateTime dateCreated = timestamp.toDate();
    DateTime now = DateTime.now();
    int diff = _hoursBetween(dateCreated, now);
    if (diff <= 24) {
      // Jiffy.locale("ru").then((value) {
        String countHours = Jiffy(dateCreated).fromNow();
        return countHours;
        // int lastDec = diff % 10;
        // if (lastDec == 1 && (diff < 10 || diff > 20)) {
        //   return 'час назад';
        // } else if ((diff < 10 || diff > 21) &&
        //     (lastDec == 2 || lastDec == 3 || lastDec == 4)) {
        //   return diff.toString() + ' часа назад';
        // } else {
        //   // if (diff > 4 && diff <= 20){
        //   return diff.toString() + ' часов назад';
        // }
        // });
    } else if (diff > 24 && diff <= 48) {
      return 'вчера';
    } else {
      final df = DateFormat('dd.MM.yyyy').format(dateCreated);
      return df.toString();
    }
  }

  int _hoursBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, from.hour, from.minute);
    return (to.difference(from).inHours);
  }
}
