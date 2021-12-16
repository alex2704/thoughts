import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/auth_bloc/auth_bloc.dart';
import 'package:thoughts/bloc/auth_bloc/auth_event.dart';
import 'package:thoughts/bloc/auth_bloc/auth_state.dart';
import 'package:thoughts/bloc/like_bloc/like_bloc.dart';
import 'package:thoughts/bloc/like_bloc/like_state.dart';
import 'package:thoughts/bloc/post_bloc/post_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_event.dart';
import 'package:thoughts/bloc/post_bloc/post_state.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/views/components/feed_item.dart';
import 'dart:developer' as developer;

import '../login_screen.dart';
import 'custom_widgets/orange_elevated_button.dart';
import 'footer.dart';

class FeedItemsList extends StatelessWidget {
  const FeedItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(PostLoadEvent());
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      // postBloc.add(PostLoadEvent());
      if (state is PostEmptyState) {
        return const Center(
          child: Text('Ошибка. Не удалось загрузить данные'),
        );
      }

      if (state is PostLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is PostLoadedState) {
        return Stack(children: <Widget>[
          ListView.builder(
              // itemCount: state.loadedPost.length,
            itemCount: 1,
              itemBuilder: (context, index) => FeedItem(
                    post: state.loadedPost[index],
                  )),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthenticatedState) {
              return const Positioned(
                  child: Align(
                      alignment: Alignment.bottomCenter, child: Footer()));
            } else {
              return Positioned(
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
                          ))));
            }
          })
        ]);
      }
      return const Center(child: Text('Произошла ошибка'));
    });
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }
}
