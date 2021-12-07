import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thoughts/theme/colors.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: CustomColors.grey)
          ),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.home, size: 30,),
            Icon(Icons.search, size: 30,),
            FaIcon(FontAwesomeIcons.plus, size: 25,),
            FaIcon(FontAwesomeIcons.bell, size: 25,),
            Icon(Icons.account_circle, size: 30,)
          ],
        ),
      ),
    );
  }

}