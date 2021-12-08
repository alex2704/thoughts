import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/views/components/comment.dart';
import 'package:thoughts/views/components/feed_item.dart';
import 'package:thoughts/views/components/header.dart';

import 'components/footer.dart';

class PostScreen extends StatelessWidget {
  final Post post;
  final bool isFullPost;

  const PostScreen({required this.post,
    required this.isFullPost,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Scrollbar(
        thickness: 5.0,
        radius: const Radius.circular(10.0),
        child: Stack(
          children: <Widget>[
            ListView(
              children: [
              isFullPost == true ?
                  FeedItem(post: post):
                    Container(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 125,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return Comment();
                      }),
                )
              ],
            ),
            const Positioned(
                child:
                    Align(alignment: Alignment.bottomCenter, child: Footer()))
          ],
        ),
      ),
    );
  }
}
