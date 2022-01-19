import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/constants.dart';
import 'package:thoughts/entities/info_user.dart';
import 'package:thoughts/shared_preferences_util.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/components/header.dart';

import 'components/custom_widgets/orange_elevated_button.dart';
import 'components/feed_items_list.dart';

class ProfileScreen extends StatelessWidget {
  final InfoUser infoUser;
  late final String _uid;

  ProfileScreen({required this.infoUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: FutureBuilder(
        future: SharedPreferencesUtil.getData<String>(Constants.uid)
          .then((value) => _uid = value),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    infoUser.idAvatar == 0 ?
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: CircleAvatar(
                          backgroundImage:
                          AssetImage('assets/images/no_photo.jpg'),
                          radius: 50,
                    ),
                      )
                      : Container(),
                    Expanded(
                        child: Text(infoUser.description, style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                    ),
                      )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Text(infoUser.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600
                          ),),
                          Text(infoUser.login,
                              style: const TextStyle(
                                  fontSize: 14,
                                fontWeight: FontWeight.w400
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container()),
                    infoUser.uid == _uid ?
                    MyOrangeElevatedButton(
                      onPressed: () => {},
                      edgeInsetsGeometry:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child:
                      const Text("Редактировать"),
                      fontSize: 14,
                    ) :
                    MyOrangeElevatedButton(
                        onPressed: () => {},
                        edgeInsetsGeometry:
                        const EdgeInsets.symmetric(horizontal: 20),
                        child:
                        const Text("Подписаться"),
                        fontSize: 14,
                      ),
                  ],
                ),
                  // numbers of posts, subs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          children: [
                            Text(
                              infoUser.postsCount.toString(),
                              style:
                              const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Посты',
                              style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          children: const [
                            Text('62',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            Text('Подписчики',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: Column(
                          children: const [
                            Text('35',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            Text('Подписки',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400))
                          ],
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical:8.0),
                    child: Divider(
                      color: CustomColors.grey,
                      height: 10,
                    ),
                  ),
                const Expanded(child: FeedItemsList())
              ],
            ),
          );
          }
          else {
            return Container();
          }
        }
      )
    );
  }
}