import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Comment extends Equatable{
  final int idComment;
  final int idUser;
  final int idPost;
  final String content;
  final DateTime dateCreated;


  const Comment({
    required this.idComment,
    required this.idUser,
    required this.idPost,
    required this.content,
    required this.dateCreated});

  @override
  List<Object?> get props => [idComment, idUser, idPost, content, dateCreated];
}