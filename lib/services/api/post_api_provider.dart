import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thoughts/entities/post.dart';
import 'dart:developer' as developer;

class PostProvider {


  FirebaseFirestore? _instance;
  final List<Post> _posts = [];

  List<Post> getPosts() {
    return _posts;
  }

  Future<List<Post>> getPostsCollectionFromFirebase() async {

    _instance = FirebaseFirestore.instance;
    CollectionReference posts = _instance!.collection("posts");

    DocumentSnapshot snapshot = await posts.doc('Post1').get();
    var data = snapshot.data() as Map;
    var postsData = data['allposts'] as List<dynamic>;

    for (var catData in postsData) {
      Post cat = Post.fromJson(catData);
      _posts.add(cat);
    }

    return _posts;
  }
}