import 'package:flutter/material.dart';
import 'package:thoughts/views/components/feed_item.dart';
import 'package:thoughts/views/components/header.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: Scrollbar(
          thickness: 5.0,
          radius: const Radius.circular(10.0),
          child:ListView(
            children: [
              FeedItem(),
              FeedItem(),
              FeedItem()
            ],
        )));
  }
}
