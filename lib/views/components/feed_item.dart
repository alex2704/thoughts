import 'package:flutter/material.dart';
import 'package:flutter/material.dart.';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:thoughts/entities/post.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/post_screen.dart';

class FeedItem extends StatelessWidget {
  final Post post;

  const FeedItem({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 30.0,
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
                      child: Text(
                        '${post.description}',
                        textAlign: TextAlign.left,
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
  }

  void _navigateToPostPage(BuildContext context, post) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PostScreen(post: post, isFullPost: true);
    }));
  }
}
