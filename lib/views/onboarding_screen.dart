import 'package:flutter/material.dart';
import 'package:thoughts/theme/colors.dart';

import 'components/custom_widgets/grey_elevated_button.dart';
import 'feed_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.orange,
      body: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Text(
                'Добро пожаловать в THOUGHTS',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1
              ),
              Center(child: Padding(padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Image.asset('assets/images/onboarding.png'),)),
              const Text(
                'Onboarding label',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text('Lorem ipsum dolor sit amet consectetur, '
                  'adipisicing elit. Explicabo necessitatibus nihil officiis '
                  'exercitationem laboriosam voluptas, sequi voluptate mollitia '
                  'perferendis odio magnam autem rem unde quibusdam maxime '
                  'illum repellat sunt perspiciatis.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 16,
                  fontWeight: FontWeight.w300
              )),),
              MyGreyElevatedButton(onPressed: () {
                _navigateToFeedPage(context);
              },
                  child: const Text('Продолжить'))
            ],
          )),
    );
  }

  void _navigateToFeedPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return const FeedScreen();
    }), (Route<dynamic> route) => false);
  }
}
