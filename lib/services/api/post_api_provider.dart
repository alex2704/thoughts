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

  Future<List<Post>> getPostsCollectionFromFirebase(String userId) async {
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

      //getting info about likes
      var like = _instance!.collection("likes").where("id_post", isEqualTo: cat.idPost).where("id_user", isEqualTo: userId);
      QuerySnapshot likeSnapshot = await like.get();
      try {
        likeSnapshot.docs.first;
        cat.isLiked = true;
      } catch(error) {
        cat.isLiked = false;
      }
      _posts.add(cat);
    }

    return _posts;
  }

  Future<List<Post>> getPostsCollectionWithoutLoginFromFirebase() async {
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
      cat.isLiked = false;
      _posts.add(cat);
    }

    return _posts;
  }

  Future<Post> createPostInFirebase(String userId, String content) async {
    Timestamp timestamp = Timestamp.fromDate(DateTime.now());
    _instance = FirebaseFirestore.instance;

    DocumentReference docReference = _instance!.collection("posts").doc();
    String idDocument = docReference.id;
    await _instance!.collection("posts").doc(idDocument).set({
      "id_post": idDocument,
      "id_user": userId,
      "comments_count": 0,
      "likes_count": 0,
      "is_liked": 0,
      "description": content,
      "date_created": timestamp,
      "url_img": ""
    });

    Post post = Post(idPost: idDocument,
        idUser: userId, urlImg: "", description: content, dateCreated: timestamp,
    commentsCount: 0, likesCount: 0, isLiked: false);

    //getting info about user
    DocumentReference user = _instance!.doc("users/${userId}");

    DocumentSnapshot userSnapshot = await user.get();
    var userData = userSnapshot.data() as dynamic;
    post.infoUser = InfoUser.fromJson(userData);
    _posts.add(post);

    return post;
  }
}
