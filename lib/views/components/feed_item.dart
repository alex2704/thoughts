import 'package:flutter/material.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:like_button/like_button.dart';
import 'package:thoughts/bloc/like_bloc/like_bloc.dart';
import 'package:thoughts/bloc/like_bloc/like_event.dart';
import 'package:thoughts/bloc/like_bloc/like_state.dart';
import 'package:thoughts/bloc/post_bloc/post_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_event.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/post_screen.dart';

class FeedItem extends StatelessWidget {
  final Post post;

  FeedItem({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LikeBloc>(
        create: (context) => LikeBloc(post.isLiked ? LikePutState() : LikeEmptyState()),
    child: FeedItemChild(post: post,));
  }
}

class FeedItemChild extends StatelessWidget {

  final Post post;
  late bool isLiked;
  late final postBloc;

  FeedItemChild({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final icon = isLiked ? Icons.favorite : Icons.favorite_outline;
    // final color = isLiked ? Colors.red : Colors.white;
    final LikeBloc likeBloc = BlocProvider.of<LikeBloc>(context);
    postBloc = BlocProvider.of<PostBloc>(context);
    isLiked = post.isLiked;
    // return BlocProvider<LikeBloc>(
    //   create: (context) => LikeBloc(post.isLiked ? LikePutState() : LikeEmptyState()),
    //   child:
    return Column(children: [
        Container(
          // color: Colors.orange,
          child: IntrinsicHeight(
              child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  post.infoUser.idAvatar == 0
                      ? const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/no_photo.jpg'),
                          radius: 30,
                        )
                      : Container(),
                  // LikeButton(
                  //     isLiked: post.isLiked,
                  //     bubblesSize: 0,
                  //     onTap: onLikeButtonTapped),
                    BlocBuilder<LikeBloc, LikeState>(
                      builder: (context, state) {
                        print(state);
                        if (state is LikeEmptyState) {
                          return SizedBox(
                            height: 37,
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(
                                Icons.favorite_outline, color: Colors.black, size: 30,),
                              onPressed: () {
                                isLiked = !isLiked;
                                onLikeButtonTapped(isLiked);
                                // isLiked = !post.isLiked;
                                // post.isLiked = isLiked;
                                likeBloc.add(LikeButtonPressedEvent(isLiked: isLiked));
                                // postBloc.add(PostLikedEvent(post: post));
                              },
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: 37,
                            child: IconButton(
                              icon: const Icon(
                                Icons.favorite, color: Colors.red, size: 30,),
                              onPressed: () {
                                isLiked = !isLiked;
                                onLikeButtonTapped(isLiked);
                                // isLiked = !post.isLiked;
                                // post.isLiked = isLiked;
                                likeBloc.add(LikeButtonPressedEvent(isLiked: isLiked));
                                // postBloc.add(PostLikedEvent(post: post));
                              },
                            ),
                          );
                        }
                      })
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(
                            post.infoUser.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '@${post.infoUser.login}',
                            style:
                                const TextStyle(color: CustomColors.light_grey),
                          )
                        ]),
                        const Icon(Icons.more_horiz,
                            color: Colors.black, size: 30.0)
                      ],
                    ),
                    InkWell(
                        child: Text(
                          '${post.description}',
                          textAlign: TextAlign.left,
                        ),
                        onTap: () => _navigateToPostPage(context, post)),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => _goBack(context),
                            child: const FaIcon(
                              FontAwesomeIcons.comment,
                              size: 25.0,
                            ),
                          ),
                          Text(
                            post.dateCreated,
                            style:
                                const TextStyle(color: CustomColors.light_grey),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.only(top: 20),
                    )
                  ],
                ),
              ),
            ],
          )),
          padding: const EdgeInsets.only(
              top: 20.0, left: 20.0, bottom: 20.0, right: 20.0),
        ),
        const Divider(color: CustomColors.light_grey, thickness: 1)
      ]);
    // );
  }

  void _navigateToPostPage(BuildContext context, post) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PostScreen(post: post, isFullPost: true);
    }));
  }

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    postBloc.add(PostLikedEvent(post: post));
    // isLiked = !post.isLiked;
    // post.isLiked = isLiked;
    return isLiked;
  }
}
