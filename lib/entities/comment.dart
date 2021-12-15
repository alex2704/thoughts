import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:thoughts/entities/info_user.dart';

class Comment extends Equatable {
  final String idComment;
  final String idUser;
  final String idPost;
  final String content;
  late final String dateCreated;
  late final bool isOwn;
  late final InfoUser infoUser;

  Comment(
      {required this.idComment,
      required this.idUser,
      required this.idPost,
      required this.content,
      required Timestamp dateCreated}) {
    this.dateCreated = _toDisplayedDate(dateCreated);
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

  _toDisplayedDate(Timestamp timestamp) {
    DateTime dateCreated = timestamp.toDate();
    DateTime now = DateTime.now();
    int diff = _hoursBetween(dateCreated, now);
    if (diff <= 24) {
      final df = DateFormat('hh:mm').format(dateCreated);
      return df;
    } else if (diff > 24 && diff <= 48) {
      return 'вчера';
    } else if (diff > 48 && diff <= 8760){
      final df = DateFormat('dd.MM').format(dateCreated);
      return df.toString();
    } else {
      return 'давно';
    }
  }
  //
  // int _daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }

  int _hoursBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours).round();
  }
}
