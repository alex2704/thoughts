import 'package:flutter/material.dart';
import 'package:flutter/material.dart.';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thoughts/theme/colors.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({Key? key}) : super(key: key);

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
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/x7.jpg'),
                  radius: 40,
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 40.0,
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
                          'Other name',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '@nickname',
                          style: TextStyle(color: CustomColors.light_grey),
                        )
                      ]),
                      Icon(Icons.more_horiz, color: Colors.black, size: 30.0)
                    ],
                  ),
                  Text(
                    'Lorem '
                    'ipsum dolor sit amet, consectetur adipiscing elit,'
                    ' sed do eiusmod tempor incididunt ut labore et '
                    'dolore magna aliqua. Ut enim ad minim veniam,'
                    ' quis nostrud.Lorem '
                    'ipsum dolor sit amet, consectetur adipiscing elit,'
                    ' sed do eiusmod tempor incididunt ut labore et '
                    'dolore magna aliqua. Ut enim ad minim veniam,'
                    ' quis nostrud.Lorem '
                    'ipsum dolor sit amet, consectetur adipiscing elit,'
                    ' sed do eiusmod tempor incididunt ut labore et '
                    'dolore magna aliqua. Ut enim ad minim veniam,'
                    ' quis nostrud.',
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.comment,
                          size: 35.0,
                        ),
                        Text(
                          '7 часов назад',
                          style: TextStyle(color: CustomColors.light_grey),
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
      const Divider(
        color: CustomColors.light_grey,
        thickness: 1
      )
    ]);
  }
}
