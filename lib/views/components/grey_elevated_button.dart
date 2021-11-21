import 'package:flutter/material.dart';
import 'package:thoughts/theme/colors.dart';

class MyGreyElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const MyGreyElevatedButton({required this.child, required this.onPressed,
  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton
      (onPressed: onPressed, child: child,
      style: ElevatedButton.styleFrom(
        primary: CustomColors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        textStyle: const TextStyle(fontSize: 18, color: Colors.white)
      ),);
  }


}