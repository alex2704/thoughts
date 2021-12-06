import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_bloc.dart';
import 'package:thoughts/repositories/post_repository.dart';
import 'package:thoughts/views/components/feed_item.dart';
import 'package:thoughts/views/components/header.dart';
import 'package:thoughts/views/components/custom_widgets/orange_elevated_button.dart';
import 'package:thoughts/views/login_screen.dart';
import 'package:thoughts/views/post_screen.dart';

import 'components/feed_items_list.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);
  final postsRepository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc(postRepository: postsRepository),
      child: Scaffold(
          appBar: Header(),
          body: Scrollbar(
              thickness: 5.0,
              radius: const Radius.circular(10.0),
              child: FeedItemsList()
              // ]
              // ),
              )),
    );
  }
}
