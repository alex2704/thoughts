import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thoughts/entities/comment.dart';
import 'dart:developer' as developer;

class CommentProvider {
  FirebaseFirestore? _instance;
  final List<Comment> _comments = [];

  List<Comment> getComments() {
    return _comments;
  }

  Future<List<Comment>> getCommentsCollectionFromFirebase(
      String postId, String userId) async {
    _instance = FirebaseFirestore.instance;

    //getting info about comments
    CollectionReference comments = _instance!.collection("comments");

    QuerySnapshot querySnapshot = await comments.where("id_post", isEqualTo: postId).get();
    List<dynamic> commentsData = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (var catData in commentsData) {
      Comment cat = Comment.fromJson(catData);
      if (userId == cat.idUser) {
        cat.isOwn = true;
      }
      _comments.add(cat);
    }

    return _comments;
  }
}
