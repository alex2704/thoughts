import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String idComment;
  final String idUser;
  final String idPost;
  final String content;
  late final DateTime dateCreated;
  late final bool isOwn;

  Comment(
      {required this.idComment,
      required this.idUser,
      required this.idPost,
      required this.content,
      required Timestamp dateCreated}) {
    this.dateCreated = dateCreated.toDate();
  }

  @override
  List<Object?> get props =>
      [idComment, idUser, idPost, content, dateCreated];

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        idComment: json['id_comment'],
        idUser: json['id_user'],
        idPost: json['id_post'],
        content: json['content'],
        dateCreated: json['date_created']);
  }
}
