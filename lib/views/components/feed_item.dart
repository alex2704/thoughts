import 'package:flutter/material.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thoughts/bloc/post_bloc/post_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_event.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/post_screen.dart';

class FeedItem extends StatefulWidget {
  final Post post;
  final bool isLiked;

  FeedItem({required this.post, this.isLiked = false, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => FeedItemState(post: post);
}

class FeedItemState extends State<FeedItem> {
  final Post post;
  late bool _isLiked;
  late PostBloc postBloc;

  FeedItemState({required this.post}) : super();

  @override
  void initState() {
    super.initState();
    _isLiked = post.isLiked;
  }

  @override
  void didUpdateWidget(FeedItem oldWidget) {
    _isLiked = post.isLiked;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final icon = _isLiked ? Icons.favorite : Icons.favorite_outline;
    final color = _isLiked ? Colors.red : Colors.black;
    postBloc = BlocProvider.of<PostBloc>(context);
    return Column(children: [
      Container(
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
                SizedBox(
                  height: 37,
                  child: IconButton(
                      onPressed: () => setState(() {
                        _isLiked = onLikeButtonTapped(_isLiked);
                          }),
                      icon: Icon(
                        icon,
                        color: color,
                        size: 30,
                      )),
                )
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
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 20),
                        child: Text(
                          '${post.description}',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      onTap: () => _navigateToPostPage(context, post)),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.comment,
                          size: 25.0,
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

  bool onLikeButtonTapped(bool isLiked) {
    postBloc.add(PostLikedEvent(post: post));
    return !isLiked;
  }
}
