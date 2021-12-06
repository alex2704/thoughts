import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/views/components/comment.dart';
import 'package:thoughts/views/components/feed_item.dart';
import 'package:thoughts/views/components/header.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: ListView(
        children:  [
          // FeedItem(),
          // ListView(
          //   children: [
              Comment(),
              Comment(),
              Comment(),
              Comment(),
              Comment(),
              Comment(),
            // ],
          // )
        ],
      ),
    );
  }
}