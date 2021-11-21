import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thoughts/views/components/feed_item.dart';
import 'package:thoughts/views/components/header.dart';
import 'package:thoughts/views/components/custom_widgets/orange_elevated_button.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: Scrollbar(
            thickness: 5.0,
            radius: const Radius.circular(10.0),
            child: Stack(children: <Widget>[
              ListView(
                children: [
                  FeedItem(),
                  FeedItem(),
                  FeedItem(),
                ],
                // )
              ),
              Positioned(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: MyOrangeElevatedButton(
                            child: const Text('Войти в аккаунт'),
                              onPressed: () {
                              Navigator.pushNamed(context, '/login');
                              },
                            edgeInsetsGeometry: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                          ))))
            ])
            // ]
            // ),
            ));
  }
}
