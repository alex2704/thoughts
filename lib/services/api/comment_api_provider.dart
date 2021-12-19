import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thoughts/entities/comment.dart';
import 'dart:developer' as developer;

import 'package:thoughts/entities/info_user.dart';

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
      else {
        cat.isOwn = false;
      }

      //getting info about user
      DocumentReference user = _instance!.doc("users/${cat.idUser}");

      DocumentSnapshot userSnapshot = await user.get();
      var userData = userSnapshot.data() as dynamic;
      cat.infoUser = InfoUser.fromJson(userData);

      _comments.add(cat);
    }

    return _comments;
  }

  Future<Comment> createCommentInFirebase(String userId, String postId, String content) async{
    Timestamp timestamp = Timestamp.fromDate(DateTime.now());
    _instance = FirebaseFirestore.instance;

    DocumentReference docReference = _instance!.collection("comments").doc();
    String idDocument = docReference.id;
    await _instance!.collection("comments").doc(idDocument).set({
      "id_comment": idDocument,
      "id_user": userId,
      "id_post": postId,
      "content": content,
      "date_created": timestamp
    });

    Comment comment = Comment(idComment: idDocument,
        idUser: userId, idPost: postId, content: content, dateCreated: timestamp);

    //getting info about user
    DocumentReference user = _instance!.doc("users/${userId}");

    DocumentSnapshot userSnapshot = await user.get();
    var userData = userSnapshot.data() as dynamic;
    comment.infoUser = InfoUser.fromJson(userData);
    comment.isOwn = true;
    _comments.add(comment);

    return comment;
  }

  Future<void> deleteCommentInFirebase(String commentId) async {
    _instance = FirebaseFirestore.instance;
    CollectionReference commentsCollection = _instance!.collection("comments");
    await _instance!.doc("comments/$commentId").delete();
    _comments.removeWhere((element) => element.idComment == commentId);
  }
}
