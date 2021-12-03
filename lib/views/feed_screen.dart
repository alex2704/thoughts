import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thoughts/views/components/feed_item.dart';
import 'package:thoughts/views/components/header.dart';
import 'package:thoughts/views/components/custom_widgets/orange_elevated_button.dart';
import 'package:thoughts/views/login_screen.dart';
import 'package:thoughts/views/post_screen.dart';

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
                              _navigateToLoginPage(context);
                              },
                            edgeInsetsGeometry: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                          ))))
            ])
            // ]
            // ),
            ));
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }
}
