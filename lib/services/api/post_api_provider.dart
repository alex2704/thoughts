import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thoughts/entities/post.dart';
import 'package:http/http.dart' as http;
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
  // final CollectionReference postList = FirebaseFirestore.instance.collection("posts");



  // Future<List<Post>> getAllPosts() async {
  //   final response = await http.get(Uri.parse(''));
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> postJson = json.decode(response.body);
  //     return postJson.map((json) => Post.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Error fetching post');
  //   }
  // }
  
  // Future getPostList() async {
  //
  //   List itemsList = [];
  //   try {
  //     await postList.get().then((querySnapshot) {
  //       for (var element in querySnapshot.docs) {
  //         itemsList.add(element.data());
  //       }
  //     });
  //   } catch (e) {
  //     throw Exception('Error fetching post');
  //   }
  // }
  //
  // Future<List<Post>> getAllPosts() async {
  //   List<Post> itemsList = [];
  //   try {
  //     await postList.get().then((querySnapshot) {
  //       for (var element in querySnapshot.docs) {
  //         itemsList.add(element.data());
  //       }
  //     });
  //     return itemsList.map((json) => Post.fromJson(json)).toList();
  //   } catch (e) {
  //     throw Exception('Error fetching post');
  //   }
  // }
}