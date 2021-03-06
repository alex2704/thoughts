import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thoughts/constants.dart';
import 'package:thoughts/repositories/info_user_repository.dart';
import 'package:thoughts/shared_preferences_util.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/feed_screen.dart';
import 'package:thoughts/views/profile_screen.dart';

import '../add_post_screen.dart';

class Footer extends StatelessWidget {
  final InfoUserRepository _infoUserRepository = InfoUserRepository();
  Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: CustomColors.grey)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: const Icon(
                Icons.home,
                size: 30,
              ),
              onTap: () => _navigateToHomePage(context),
            ),
            const Icon(
              Icons.search,
              size: 30,
            ),
            GestureDetector(
              child: const FaIcon(
                FontAwesomeIcons.plus,
                size: 25,
              ),
              onTap: () => _navigateToCreatePost(context),
            ),
            GestureDetector(
              child: const FaIcon(
                FontAwesomeIcons.bell,
                size: 25,
              ),
              onTap: () => _navigateToNotifications(context),
            ),
            GestureDetector(
              child: const Icon(
                Icons.account_circle,
                size: 30,
                color: CustomColors.orange,
              ),
              onTap: () => _navigateToMyProfile(context),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return FeedScreen();
    }), (r) => false);
  }

  void _navigateToCreatePost(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddPostScreen();
    }));
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return FeedScreen();
    }));
  }

  void _navigateToMyProfile(BuildContext context) async {
    String uid = await SharedPreferencesUtil.getData<String>(Constants.uid);
    var infoUser = await _infoUserRepository.getCurrentUser(uid);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfileScreen(infoUser: infoUser);
    }));
  }
}
