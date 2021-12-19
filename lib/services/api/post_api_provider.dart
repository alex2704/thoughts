import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thoughts/entities/info_user.dart';
import 'package:thoughts/entities/post.dart';
import 'dart:developer' as developer;

class PostProvider {
  FirebaseFirestore? _instance;
  final List<Post> _posts = [];

  List<Post> getPosts() {
    return _posts;
  }

  void changeLikeStatus(Post post, String userId) async {
    post.isLiked = !post.isLiked;

    _instance = FirebaseFirestore.instance;
    CollectionReference likesCollection = _instance!.collection("likes");
    if (post.isLiked) {
      // create new instance
      await likesCollection.add({"id_post": post.idPost, "id_user": userId});
    } else {

      // delete new instance
      var query = likesCollection.where("id_post", isEqualTo: post.idPost).where("id_user", isEqualTo: userId);
      query.get().then((querySnapshot) => {
        for (DocumentSnapshot ds in querySnapshot.docs) {
          ds.reference.delete()
      }
      });
    }
  }

  Future<List<Post>> getPostsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;

    //getting info about posts
    CollectionReference posts = _instance!.collection("posts");

    DocumentSnapshot snapshot = await posts.doc('Post1').get();
    var data = snapshot.data() as Map;
    var postsData = data['allposts'] as List<dynamic>;

    for (var catData in postsData) {
      Post cat = Post.fromJson(catData);

      //getting info about users
      DocumentReference user = _instance!.doc("users/${cat.idUser}");

      DocumentSnapshot userSnapshot = await user.get();
      var userData = userSnapshot.data() as dynamic;
      cat.infoUser = InfoUser.fromJson(userData);
      _posts.add(cat);
    }

    return _posts;
  }
}
